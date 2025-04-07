unit UnitsStr;

{$RANGECHECKS OFF}

interface

uses
  System.Types, System.SysUtils, System.Classes, System.Generics.Collections, System.Generics.Defaults;

type
  TUnitsOfMeasurement = class(TPersistent)
  private type
    TUnit = record
      Name: string;
      Value: UInt64;
    end;
  private
    FNames: TDictionary<string, UInt64>;
    FEncodingOrder: TList<TUnit>;
  protected
    property  Names: TDictionary<string, UInt64> read FNames;
    property  EncodingOrder: TList<TUnit> read FEncodingOrder;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(const Name: string; const Value: UInt64; UseToEncode: Boolean = False);
    procedure Remove(const Name: string);
  end;

  TMilliseconds = type UInt64;

  TMillisecondsHelper = record helper for TMilliseconds
  public type
    TUnits = class(TUnitsOfMeasurement)
    private
      class var FDefaults: TUnits;
    protected
      class constructor Create;
      class destructor Destroy;
    public
      class property Defaults: TUnits read FDefaults;
    end;
  public
    function  ToString: string; overload; inline;
    function  ToString(const Units: TUnits): string; overload; inline;
    function  TryParse(const S: string): Boolean; overload; inline;
    function  TryParse(const S: string; const Units: TUnits): Boolean; overload; inline;
  public
    class function TryParse(const S: string; out Value: TMilliseconds): Boolean; overload; static; inline;
    class function TryParse(const S: string; out Value: TMilliseconds; const Units: TUnits): Boolean; overload; static; inline;
    class function Parse(const S: string): TMilliseconds; overload; static; inline;
    class function Parse(const S: string; const Units: TUnits): TMilliseconds; overload; static; inline;
  end;

function StrToUnits(const S: string; const Units: TUnitsOfMeasurement): UInt64; inline;
function TryStrToUnits(const S: string; out Value: UInt64; const Units: TUnitsOfMeasurement): Boolean;
function UnitsToStr(Value: UInt64; const Units: TUnitsOfMeasurement): string;

resourcestring
  SInvalidUnitStr = '''%s'' is not valid value string';

implementation

function UnitsToStr(Value: UInt64; const Units: TUnitsOfMeasurement): string;
var
  Parts: TArray<string>;
begin
  if Value = 0 then
    Exit('0')
  else if Units.EncodingOrder.Count = 0 then
    Exit(UIntToStr(Value));

  SetLength(Parts, Units.EncodingOrder.Count + 1);
  var J := 0;
  for var I := Units.EncodingOrder.Count - 1 downto 0 do
  begin
    var Item := Units.EncodingOrder[I];
    var Part := Value div Item.Value;

    if Part <> 0 then
    begin
      Parts[J] := UIntToStr(Part) + Item.Name;
      Inc(J);
    end;

    Value := Value mod Item.Value;
  end;

  if Value <> 0 then
  begin
    Parts[J] := UIntToStr(Value);
    Inc(J);
  end;
  SetLength(Parts, J);

  Result := string.Join(' ', Parts);
end;

function StrToUnits(const S: string; const Units: TUnitsOfMeasurement): UInt64;
begin
  if not TryStrToUnits(S, Result, Units) then
    raise EConvertError.CreateResFmt(@SInvalidUnitStr, [S]);
end;

function TryStrToUnits(const S: string; out Value: UInt64; const Units: TUnitsOfMeasurement): Boolean;
var
  UnitValue, Temp: UInt64;
  B, I, L: Integer;
begin
  Result := False;

  L := Length(S);
  if L = 0 then
    Exit;

  Value := 0;

  I := 1;
  while I <= L do
  begin
    case S[I] of
      #0..#32:
        Inc(I); //Skip spaces

      '0'..'9':
        begin
          Temp := 0;
          while (I <= L) and (S[I] >= '0') and (S[I] <= '9') do
          begin
            Temp := Temp * 10 + Ord(S[I]) - Ord('0');
            Inc(I);
          end;

          while (I <= L) and CharInSet(S[I], [#0..#32]) do
            Inc(I);

          B := I;
          while (I <= L) and (S[I] > ' ') do
            Inc(I);

          if B = I then // No units specified, must be last
          begin
            while I <= L do
            begin
              if S[I] > #32 then
                Exit(False);
              Inc(I);
            end;
            Value := Value + Temp;
            Exit(True);
          end;

          if Units.Names.TryGetValue(Copy(S, B, I - B), UnitValue) then
            Value := Value + Temp * UnitValue
          else
            Exit(False);

          Result := True;
        end;
    else
      Exit(False);
    end;
  end;
end;

{ TUnitsOfMeasurement }

constructor TUnitsOfMeasurement.Create;
begin
  inherited Create;
  FNames := TDictionary<string, UInt64>.Create(TIStringComparer.Ordinal);
  FEncodingOrder := TList<TUnit>.Create;
end;

destructor TUnitsOfMeasurement.Destroy;
begin
  FreeAndNil(FNames);
  FreeAndNil(FEncodingOrder);
  inherited;
end;

procedure TUnitsOfMeasurement.Add(const Name: string; const Value: UInt64; UseToEncode: Boolean);
begin
  Names.AddOrSetValue(Name, Value);

  if UseToEncode then
  begin
    var Item: TUnit;
    Item.Name := Name;
    Item.Value := Value;

    for var I := 0 to EncodingOrder.Count - 1 do
      if EncodingOrder[I].Value = Value then
      begin
        EncodingOrder[I] := Item;
        Exit;
      end
      else if EncodingOrder[I].Value > Value then
      begin
        EncodingOrder.Insert(I, Item);
        Exit;
      end;

    EncodingOrder.Add(Item);
  end;
end;

procedure TUnitsOfMeasurement.Remove(const Name: string);
begin
  Names.Remove(Name);

  for var I := 0 to EncodingOrder.Count - 1 do
    if EncodingOrder[I].Name = Name then
    begin
      EncodingOrder.Delete(I);
      Exit;
    end;
end;

{ TMillisecondsHelper }

function TMillisecondsHelper.ToString: string;
begin
  Result := UnitsToStr(Self, TUnits.Defaults);
end;

class function TMillisecondsHelper.TryParse(const S: string; out Value: TMilliseconds): Boolean;
begin
  Result := TryStrToUnits(S, UInt64(Value), TUnits.Defaults);
end;

class function TMillisecondsHelper.TryParse(const S: string; out Value: TMilliseconds; const Units: TUnits): Boolean;
begin
  Result := TryStrToUnits(S, UInt64(Value), Units);
end;

function TMillisecondsHelper.ToString(const Units: TUnits): string;
begin
  Result := UnitsToStr(Self, Units);
end;

class function TMillisecondsHelper.Parse(const S: string): TMilliseconds;
begin
  Result := StrToUnits(S, TUnits.Defaults);
end;

class function TMillisecondsHelper.Parse(const S: string; const Units: TUnits): TMilliseconds;
begin
  Result := StrToUnits(S, Units);
end;

function TMillisecondsHelper.TryParse(const S: string): Boolean;
begin
  Result := TryStrToUnits(S, UInt64(Self), TUnits.Defaults);
end;

function TMillisecondsHelper.TryParse(const S: string; const Units: TUnits): Boolean;
begin
  Result := TryStrToUnits(S, UInt64(Self), Units);
end;

{ TMillisecondsHelper.TUnits }

class constructor TMillisecondsHelper.TUnits.Create;
begin
  FDefaults := TMilliseconds.TUnits.Create;

  Defaults.Add('d', MSecsPerDay, True);
  Defaults.Add('day', MSecsPerDay);
  Defaults.Add('days', MSecsPerDay);

  Defaults.Add('h', SecsPerHour * MSecsPerSec, True);
  Defaults.Add('hrs', SecsPerHour * MSecsPerSec);
  Defaults.Add('hour', SecsPerHour * MSecsPerSec);
  Defaults.Add('hours', SecsPerHour * MSecsPerSec);

  Defaults.Add('m', SecsPerMin * MSecsPerSec, True);
  Defaults.Add('min', SecsPerMin * MSecsPerSec);
  Defaults.Add('mins', SecsPerMin * MSecsPerSec);
  Defaults.Add('minute', SecsPerMin * MSecsPerSec);
  Defaults.Add('minutes', SecsPerMin * MSecsPerSec);

  Defaults.Add('s', MSecsPerSec, True);
  Defaults.Add('sec', MSecsPerSec);
  Defaults.Add('secs', MSecsPerSec);
  Defaults.Add('second', MSecsPerSec);
  Defaults.Add('seconds', MSecsPerSec);
end;

class destructor TMillisecondsHelper.TUnits.Destroy;
begin
  FreeAndNil(FDefaults);
end;

end.
