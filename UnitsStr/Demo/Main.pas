unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Generics.Collections, System.Generics.Defaults;

type
  TForm7 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

uses
  UnitsStr;

{$R *.dfm}

procedure TForm7.Edit1Change(Sender: TObject);
var
  T: TMilliseconds;
begin
  var M := TMilliseconds.Parse('2 hours');

  if T.TryParse(Edit1.Text) then
  begin
    Label1.Caption := UIntToStr(T);
    Label2.Caption := T.ToString;
    Label3.Caption := UIntToStr(TMilliseconds.Parse(Label2.Caption));
  end
  else
    Label1.Caption := 'Error';

  TMilliseconds.TUnits.Defaults.Add('h', SecsPerHour * MSecsPerSec);
end;

end.
