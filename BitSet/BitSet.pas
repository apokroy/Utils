///  <summary>
///  The module contains types that allow you to manipulate individual bits in the data.
///  </summary>
unit BitSet;

interface

uses
  System.Types, System.SysUtils;

const
  {$region 'consts'}
  Bit0  = %0000000000000000000000000000000000000000000000000000000000000001;
  Bit1  = %0000000000000000000000000000000000000000000000000000000000000010;
  Bit2  = %0000000000000000000000000000000000000000000000000000000000000100;
  Bit3  = %0000000000000000000000000000000000000000000000000000000000001000;
  Bit4  = %0000000000000000000000000000000000000000000000000000000000010000;
  Bit5  = %0000000000000000000000000000000000000000000000000000000000100000;
  Bit6  = %0000000000000000000000000000000000000000000000000000000001000000;
  Bit7  = %0000000000000000000000000000000000000000000000000000000010000000;
  Bit8  = %0000000000000000000000000000000000000000000000000000000100000000;
  Bit9  = %0000000000000000000000000000000000000000000000000000001000000000;
  Bit10 = %0000000000000000000000000000000000000000000000000000010000000000;
  Bit11 = %0000000000000000000000000000000000000000000000000000100000000000;
  Bit12 = %0000000000000000000000000000000000000000000000000001000000000000;
  Bit13 = %0000000000000000000000000000000000000000000000000010000000000000;
  Bit14 = %0000000000000000000000000000000000000000000000000100000000000000;
  Bit15 = %0000000000000000000000000000000000000000000000001000000000000000;
  Bit16 = %0000000000000000000000000000000000000000000000010000000000000000;
  Bit17 = %0000000000000000000000000000000000000000000000100000000000000000;
  Bit18 = %0000000000000000000000000000000000000000000001000000000000000000;
  Bit19 = %0000000000000000000000000000000000000000000010000000000000000000;
  Bit20 = %0000000000000000000000000000000000000000000100000000000000000000;
  Bit21 = %0000000000000000000000000000000000000000001000000000000000000000;
  Bit22 = %0000000000000000000000000000000000000000010000000000000000000000;
  Bit23 = %0000000000000000000000000000000000000000100000000000000000000000;
  Bit24 = %0000000000000000000000000000000000000001000000000000000000000000;
  Bit25 = %0000000000000000000000000000000000000010000000000000000000000000;
  Bit26 = %0000000000000000000000000000000000000100000000000000000000000000;
  Bit27 = %0000000000000000000000000000000000001000000000000000000000000000;
  Bit28 = %0000000000000000000000000000000000010000000000000000000000000000;
  Bit29 = %0000000000000000000000000000000000100000000000000000000000000000;
  Bit30 = %0000000000000000000000000000000001000000000000000000000000000000;
  Bit31 = %0000000000000000000000000000000010000000000000000000000000000000;
  Bit32 = %0000000000000000000000000000000100000000000000000000000000000000;
  Bit33 = %0000000000000000000000000000001000000000000000000000000000000000;
  Bit34 = %0000000000000000000000000000010000000000000000000000000000000000;
  Bit35 = %0000000000000000000000000000100000000000000000000000000000000000;
  Bit36 = %0000000000000000000000000001000000000000000000000000000000000000;
  Bit37 = %0000000000000000000000000010000000000000000000000000000000000000;
  Bit38 = %0000000000000000000000000100000000000000000000000000000000000000;
  Bit39 = %0000000000000000000000001000000000000000000000000000000000000000;
  Bit40 = %0000000000000000000000010000000000000000000000000000000000000000;
  Bit41 = %0000000000000000000000100000000000000000000000000000000000000000;
  Bit42 = %0000000000000000000001000000000000000000000000000000000000000000;
  Bit43 = %0000000000000000000010000000000000000000000000000000000000000000;
  Bit44 = %0000000000000000000100000000000000000000000000000000000000000000;
  Bit45 = %0000000000000000001000000000000000000000000000000000000000000000;
  Bit46 = %0000000000000000010000000000000000000000000000000000000000000000;
  Bit47 = %0000000000000000100000000000000000000000000000000000000000000000;
  Bit48 = %0000000000000001000000000000000000000000000000000000000000000000;
  Bit49 = %0000000000000010000000000000000000000000000000000000000000000000;
  Bit50 = %0000000000000100000000000000000000000000000000000000000000000000;
  Bit51 = %0000000000001000000000000000000000000000000000000000000000000000;
  Bit52 = %0000000000010000000000000000000000000000000000000000000000000000;
  Bit53 = %0000000000100000000000000000000000000000000000000000000000000000;
  Bit54 = %0000000001000000000000000000000000000000000000000000000000000000;
  Bit55 = %0000000010000000000000000000000000000000000000000000000000000000;
  Bit56 = %0000000100000000000000000000000000000000000000000000000000000000;
  Bit57 = %0000001000000000000000000000000000000000000000000000000000000000;
  Bit58 = %0000010000000000000000000000000000000000000000000000000000000000;
  Bit59 = %0000100000000000000000000000000000000000000000000000000000000000;
  Bit60 = %0001000000000000000000000000000000000000000000000000000000000000;
  Bit61 = %0010000000000000000000000000000000000000000000000000000000000000;
  Bit62 = %0100000000000000000000000000000000000000000000000000000000000000;
  Bit63 = %1000000000000000000000000000000000000000000000000000000000000000;

  BitValue: array[0..63] of UInt64 = (
    Bit0,  Bit1,  Bit2,  Bit3,  Bit4,  Bit5,  Bit6,  Bit7,  Bit8,  Bit9,  Bit10, Bit11, Bit12, Bit13, Bit14, Bit15,
    Bit16, Bit17, Bit18, Bit19, Bit20, Bit21, Bit22, Bit23, Bit24, Bit25, Bit26, Bit27, Bit28, Bit29, Bit30, Bit31,
    Bit32, Bit33, Bit34, Bit35, Bit36, Bit37, Bit38, Bit39, Bit40, Bit41, Bit42, Bit43, Bit44, Bit45, Bit46, Bit47,
    Bit48, Bit49, Bit50, Bit51, Bit52, Bit53, Bit54, Bit55, Bit56, Bit57, Bit58, Bit59, Bit60, Bit61, Bit62, Bit63
  );

  SignificantBitMask: array[0..63] of UInt64 = (
    %0000000000000000000000000000000000000000000000000000000000000001,
    %0000000000000000000000000000000000000000000000000000000000000011,
    %0000000000000000000000000000000000000000000000000000000000000111,
    %0000000000000000000000000000000000000000000000000000000000001111,
    %0000000000000000000000000000000000000000000000000000000000011111,
    %0000000000000000000000000000000000000000000000000000000000111111,
    %0000000000000000000000000000000000000000000000000000000001111111,
    %0000000000000000000000000000000000000000000000000000000011111111,
    %0000000000000000000000000000000000000000000000000000000111111111,
    %0000000000000000000000000000000000000000000000000000001111111111,
    %0000000000000000000000000000000000000000000000000000011111111111,
    %0000000000000000000000000000000000000000000000000000111111111111,
    %0000000000000000000000000000000000000000000000000001111111111111,
    %0000000000000000000000000000000000000000000000000011111111111111,
    %0000000000000000000000000000000000000000000000000111111111111111,
    %0000000000000000000000000000000000000000000000001111111111111111,
    %0000000000000000000000000000000000000000000000011111111111111111,
    %0000000000000000000000000000000000000000000000111111111111111111,
    %0000000000000000000000000000000000000000000001111111111111111111,
    %0000000000000000000000000000000000000000000011111111111111111111,
    %0000000000000000000000000000000000000000000111111111111111111111,
    %0000000000000000000000000000000000000000001111111111111111111111,
    %0000000000000000000000000000000000000000011111111111111111111111,
    %0000000000000000000000000000000000000000111111111111111111111111,
    %0000000000000000000000000000000000000001111111111111111111111111,
    %0000000000000000000000000000000000000011111111111111111111111111,
    %0000000000000000000000000000000000000111111111111111111111111111,
    %0000000000000000000000000000000000001111111111111111111111111111,
    %0000000000000000000000000000000000011111111111111111111111111111,
    %0000000000000000000000000000000000111111111111111111111111111111,
    %0000000000000000000000000000000001111111111111111111111111111111,
    %0000000000000000000000000000000011111111111111111111111111111111,
    %0000000000000000000000000000000111111111111111111111111111111111,
    %0000000000000000000000000000001111111111111111111111111111111111,
    %0000000000000000000000000000011111111111111111111111111111111111,
    %0000000000000000000000000000111111111111111111111111111111111111,
    %0000000000000000000000000001111111111111111111111111111111111111,
    %0000000000000000000000000011111111111111111111111111111111111111,
    %0000000000000000000000000111111111111111111111111111111111111111,
    %0000000000000000000000001111111111111111111111111111111111111111,
    %0000000000000000000000011111111111111111111111111111111111111111,
    %0000000000000000000000111111111111111111111111111111111111111111,
    %0000000000000000000001111111111111111111111111111111111111111111,
    %0000000000000000000011111111111111111111111111111111111111111111,
    %0000000000000000000111111111111111111111111111111111111111111111,
    %0000000000000000001111111111111111111111111111111111111111111111,
    %0000000000000000011111111111111111111111111111111111111111111111,
    %0000000000000000111111111111111111111111111111111111111111111111,
    %0000000000000001111111111111111111111111111111111111111111111111,
    %0000000000000011111111111111111111111111111111111111111111111111,
    %0000000000000111111111111111111111111111111111111111111111111111,
    %0000000000001111111111111111111111111111111111111111111111111111,
    %0000000000011111111111111111111111111111111111111111111111111111,
    %0000000000111111111111111111111111111111111111111111111111111111,
    %0000000001111111111111111111111111111111111111111111111111111111,
    %0000000011111111111111111111111111111111111111111111111111111111,
    %0000000111111111111111111111111111111111111111111111111111111111,
    %0000001111111111111111111111111111111111111111111111111111111111,
    %0000011111111111111111111111111111111111111111111111111111111111,
    %0000111111111111111111111111111111111111111111111111111111111111,
    %0001111111111111111111111111111111111111111111111111111111111111,
    %0011111111111111111111111111111111111111111111111111111111111111,
    %0111111111111111111111111111111111111111111111111111111111111111,
    %1111111111111111111111111111111111111111111111111111111111111111
  );
  {$endregion}

type
  PUInt8  = ^UInt8;
  PUInt16 = ^UInt16;

  TBitInSet = record
    Position: NativeUInt;
    IsSet: Boolean;
  end;

  IBitSetEnumerator = IEnumerator<TBitInSet>;

  TBitSetEnumeratorBase = class(TInterfacedObject, IEnumerator)
  public
    { IEnumerator }
    function  GetCurrent: TObject;
    function  MoveNext: Boolean;
    procedure Reset;
  end;

  ///  <summary>
  ///  Describes a type that stores a sequence consisting of a Count number of bits.
  ///  </summary>
  ///  <remarks>
  ///  Bit position is zero based
  ///  </remarks>
  TBitSet = record
  private
    FCount: NativeUInt;
    FBits: TArray<UInt64>;
    FSize: NativeUInt;
    FLength: NativeInt;
    function  GetBit(const Pos: NativeUInt): Boolean; inline;
    procedure SetBit(const Pos: NativeUInt; const Value: Boolean); inline;
  public
    constructor Create(Count: NativeUInt); overload;
    constructor Create(Data: Pointer; Count: NativeUInt); overload;
    function  GetEnumerator: IBitSetEnumerator;
    ///  <summary>
    ///  Load bitset from memory, size of referenced data must be equal to Size
    ///  </summary>
    ///  <remark>
    ///  Be carefull - no memory check provided
    ///  </remark>
    procedure Load(Data: Pointer);
    ///  <summary>
    ///  Save bitset to memory, size of buffer must be equal or greater then Size
    ///  </summary>
    ///  <remark>
    ///  Be carefull - no memory check provided
    ///  </remark>
    procedure Save(Data: Pointer);
  public
    ///  <summary>
    ///  Returns True if all bits set
    ///  </summary>
    function  All: Boolean;
    ///  <summary>
    ///  Returns True if any bit in sequnece is set
    ///  </summary>
    function  Any: Boolean;
    ///  <summary>
    ///  Invert value of all bits
    ///  </summary>
    function  Flip: TBitSet; overload;
    ///  <summary>
    ///  Invert value of bit at Pos
    ///  </summary>
    function  Flip(const Pos: NativeUInt): TBitSet; overload;
    ///  <summary>
    ///  Returns True if all bits not set
    ///  </summary>
    function  None: Boolean;
    ///  <summary>
    ///  Unset all bits
    ///  </summary>
    function  Reset: TBitSet; overload;
    ///  <summary>
    ///  Unset bit at Pos
    ///  </summary>
    function  Reset(const Pos: NativeUInt): TBitSet; overload;
    ///  <summary>
    ///  Set all bits
    ///  </summary>
    function  &Set: TBitSet; overload;
    ///  <summary>
    ///  Set bit at Pos
    ///  </summary>
    function  &Set(const Pos: NativeUInt): TBitSet; overload;
    ///  <summary>
    ///  A string where each bit set has a corresponding character of 1, and 0 if the bit is unset.
    ///  </summary>
    function  ToString: string;
    ///  <summary>
    ///  Get or Set|Unset individual bits at Pos
    ///  </summary>
    property  Bit[const Pos: NativeUInt]: Boolean read GetBit write SetBit; default;
    ///  <summary>
    ///  Count of bits
    ///  </summary>
    property  Count: NativeUInt read FCount;
    ///  <summary>
    ///  Size of data
    ///  </summary>
    property  Size: NativeUInt read FSize;
  public
    class operator Explicit(const Value: Byte): TBitSet; static; inline;
    class operator Explicit(const Value: Word): TBitSet; static; inline;
    class operator Explicit(const Value: UInt32): TBitSet; static; inline;
    class operator Explicit(const Value: UInt64): TBitSet; static; inline;
    class operator Explicit(const Value: TBitSet): Byte; static; inline;
    class operator Explicit(const Value: TBitSet): Word; static; inline;
    class operator Explicit(const Value: TBitSet): UInt32; static; inline;
    class operator Explicit(const Value: TBitSet): UInt64; static; inline;
    class operator Equal(const L, R: TBitSet): Boolean; static; inline;
    class operator NotEqual(const L, R: TBitSet): Boolean; static; inline;
    class operator BitwiseAnd(const L, R: TBitSet): TBitSet; static; inline;
    class operator BitwiseOr(const L, R: TBitSet): TBitSet; static; inline;
    class operator BitwiseXor(const L, R: TBitSet): TBitSet; static; inline;
    class operator LogicalNot(const Value: TBitSet): TBitSet; static; inline;
  end;

  TBitSetEnumerator = class(TBitSetEnumeratorBase, IBitSetEnumerator)
  private
    FBits: TBitSet;
    FIndex: NativeUInt;
  public
    constructor Create(const Bits: TBitSet);
    function  GetCurrent: TBitInSet;
    function  MoveNext: Boolean;
    procedure Reset;
  end;

  TBitSet8 = record
  public const
    Size  = 1;
    Count = 8;
  private
    FBits: Byte;
    function  GetBit(const Pos: NativeUInt): Boolean; inline;
    procedure SetBit(const Pos: NativeUInt; const Value: Boolean); inline;
  public
    constructor Create(Value: UInt8);
    function  GetEnumerator: IBitSetEnumerator;
  public
    function  All: Boolean;
    function  Any: Boolean;
    function  Flip: TBitSet8; overload;
    function  Flip(const Pos: NativeUInt): TBitSet8; overload;
    function  None: Boolean;
    function  Reset: TBitSet8; overload;
    function  Reset(const Pos: NativeUInt): TBitSet8; overload;
    function  &Set: TBitSet8; overload;
    function  &Set(const Pos: NativeUInt): TBitSet8; overload;
    function  ToString: string;
    property  Bit[const Pos: NativeUInt]: Boolean read GetBit write SetBit; default;
  public
    class operator Implicit(const Value: TBitSet8): UInt8; static; inline;
    class operator Equal(const L, R: TBitSet8): Boolean; static; inline;
    class operator NotEqual(const L, R: TBitSet8): Boolean; static; inline;
    class operator BitwiseAnd(const L, R: TBitSet8): TBitSet8; static; inline;
    class operator BitwiseOr(const L, R: TBitSet8): TBitSet8; static; inline;
    class operator BitwiseXor(const L, R: TBitSet8): TBitSet8; static; inline;
    class operator LogicalNot(const Value: TBitSet8): TBitSet8; static; inline;
  end;

  TBitSet8Enumerator = class(TBitSetEnumeratorBase, IBitSetEnumerator)
  private
    FBits: TBitSet8;
    FIndex: NativeUInt;
  public
    constructor Create(const Bits: TBitSet8);
    function  GetCurrent: TBitInSet;
    function  MoveNext: Boolean;
    procedure Reset;
  end;

  TBitSet16 = record
  public const
    Size  = 2;
    Count = 16;
  private
    FBits: Word;
    function  GetBit(const Pos: NativeUInt): Boolean; inline;
    procedure SetBit(const Pos: NativeUInt; const Value: Boolean); inline;
  public
    constructor Create(Value: UInt16);
    function  GetEnumerator: IBitSetEnumerator;
  public
    function  All: Boolean;
    function  Any: Boolean;
    function  Flip: TBitSet16; overload;
    function  Flip(const Pos: NativeUInt): TBitSet16; overload;
    function  None: Boolean;
    function  Reset: TBitSet16; overload;
    function  Reset(const Pos: NativeUInt): TBitSet16; overload;
    function  &Set: TBitSet16; overload;
    function  &Set(const Pos: NativeUInt): TBitSet16; overload;
    function  ToString: string;
    property  Bit[const Pos: NativeUInt]: Boolean read GetBit write SetBit; default;
  public
    class operator Implicit(const Value: TBitSet16): UInt16; static; inline;
    class operator Explicit(const Value: TBitSet16): TBitSet8; static; inline;
    class operator Equal(const L, R: TBitSet16): Boolean; static; inline;
    class operator NotEqual(const L, R: TBitSet16): Boolean; static; inline;
    class operator BitwiseAnd(const L, R: TBitSet16): TBitSet16; static; inline;
    class operator BitwiseOr(const L, R: TBitSet16): TBitSet16; static; inline;
    class operator BitwiseXor(const L, R: TBitSet16): TBitSet16; static; inline;
    class operator LogicalNot(const Value: TBitSet16): TBitSet16; static; inline;
  end;

  TBitSet16Enumerator = class(TBitSetEnumeratorBase, IBitSetEnumerator)
  private
    FBits: TBitSet16;
    FIndex: NativeUInt;
  public
    constructor Create(const Bits: TBitSet16);
    function  GetCurrent: TBitInSet;
    function  MoveNext: Boolean;
    procedure Reset;
  end;

  TBitSet32 = record
  public const
    Size  = 4;
    Count = 32;
  private
    FBits: UInt32;
    function  GetBit(const Pos: NativeUInt): Boolean; inline;
    procedure SetBit(const Pos: NativeUInt; const Value: Boolean); inline;
  public
    constructor Create(Value: UInt32);
    function  GetEnumerator: IBitSetEnumerator;
  public
    function  All: Boolean;
    function  Any: Boolean;
    function  Flip: TBitSet32; overload;
    function  Flip(const Pos: NativeUInt): TBitSet32; overload;
    function  None: Boolean;
    function  Reset: TBitSet32; overload;
    function  Reset(const Pos: NativeUInt): TBitSet32; overload;
    function  &Set: TBitSet32; overload;
    function  &Set(const Pos: NativeUInt): TBitSet32; overload;
    function  ToString: string;
    property  Bit[const Pos: NativeUInt]: Boolean read GetBit write SetBit; default;
  public
    class operator Implicit(const Value: TBitSet32): UInt32; static; inline;
    class operator Explicit(const Value: TBitSet32): TBitSet8; static; inline;
    class operator Explicit(const Value: TBitSet32): TBitSet16; static; inline;
    class operator Equal(const L, R: TBitSet32): Boolean; static; inline;
    class operator NotEqual(const L, R: TBitSet32): Boolean; static; inline;
    class operator BitwiseAnd(const L, R: TBitSet32): TBitSet32; static; inline;
    class operator BitwiseOr(const L, R: TBitSet32): TBitSet32; static; inline;
    class operator BitwiseXor(const L, R: TBitSet32): TBitSet32; static; inline;
    class operator LogicalNot(const Value: TBitSet32): TBitSet32; static; inline;
  end;

  TBitSet32Enumerator = class(TBitSetEnumeratorBase, IBitSetEnumerator)
  private
    FBits: TBitSet32;
    FIndex: NativeUInt;
  public
    constructor Create(const Bits: TBitSet32);
    function  GetCurrent: TBitInSet;
    function  MoveNext: Boolean;
    procedure Reset;
  end;

  TBitSet64 = record
  public const
    Size  = 8;
    Count = 64;
  private
    FBits: UInt64;
    function  GetBit(const Pos: NativeUInt): Boolean; inline;
    procedure SetBit(const Pos: NativeUInt; const Value: Boolean); inline;
  public
    constructor Create(Value: UInt64);
    function  GetEnumerator: IBitSetEnumerator;
  public
    function  All: Boolean;
    function  Any: Boolean;
    function  Flip: TBitSet64; overload;
    function  Flip(const Pos: NativeUInt): TBitSet64; overload;
    function  None: Boolean;
    function  Reset: TBitSet64; overload;
    function  Reset(const Pos: NativeUInt): TBitSet64; overload;
    function  &Set: TBitSet64; overload;
    function  &Set(const Pos: NativeUInt): TBitSet64; overload;
    function  ToString: string;
    property  Bit[const Pos: NativeUInt]: Boolean read GetBit write SetBit; default;
  public
    class operator Implicit(const Value: TBitSet64): UInt64; static; inline;
    class operator Explicit(const Value: TBitSet64): TBitSet8; static; inline;
    class operator Explicit(const Value: TBitSet64): TBitSet16; static; inline;
    class operator Explicit(const Value: TBitSet64): TBitSet32; static; inline;
    class operator Equal(const L, R: TBitSet64): Boolean; static; inline;
    class operator NotEqual(const L, R: TBitSet64): Boolean; static; inline;
    class operator BitwiseAnd(const L, R: TBitSet64): TBitSet64; static; inline;
    class operator BitwiseOr(const L, R: TBitSet64): TBitSet64; static; inline;
    class operator BitwiseXor(const L, R: TBitSet64): TBitSet64; static; inline;
    class operator LogicalNot(const Value: TBitSet64): TBitSet64; static; inline;
  end;

  TBitSet64Enumerator = class(TBitSetEnumeratorBase, IBitSetEnumerator)
  private
    FBits: TBitSet64;
    FIndex: NativeUInt;
  public
    constructor Create(const Bits: TBitSet64);
    function  GetCurrent: TBitInSet;
    function  MoveNext: Boolean;
    procedure Reset;
  end;

  {$IF defined(CPUX64)}
    TBitSetNative = TBitSet64;
  {$ELSE}
    TBitSetNative = TBitSet32;
  {$ENDIF}

  TBitSet<T: record> = record
  public const
    Size  = SizeOf(T);
    Count = SizeOf(T) * 8;
  private
    FBits: T;
    function  GetBit(const Pos: NativeUInt): Boolean; inline;
    procedure SetBit(const Pos: NativeUInt; const Value: Boolean); inline;
  public
    function  GetEnumerator: IBitSetEnumerator;
  public
    function  All: Boolean;
    function  Any: Boolean;
    function  Flip: TBitSet<T>; overload;
    function  Flip(const Pos: NativeUInt): TBitSet<T>; overload;
    function  None: Boolean;
    function  Reset: TBitSet<T>; overload;
    function  Reset(const Pos: NativeUInt): TBitSet<T>; overload;
    function  &Set: TBitSet<T>; overload;
    function  &Set(const Pos: NativeUInt): TBitSet<T>; overload;
    function  ToString: string;
    property  Bit[const Pos: NativeUInt]: Boolean read GetBit write SetBit; default;
  public
    class operator Implicit(const Value: TBitSet<T>): T; static; inline;
    class operator Equal(const L, R: TBitSet<T>): Boolean; static; inline;
    class operator NotEqual(const L, R: TBitSet<T>): Boolean; static; inline;
    class operator BitwiseAnd(const L, R: TBitSet<T>): TBitSet<T>; static; inline;
    class operator BitwiseOr(const L, R: TBitSet<T>): TBitSet<T>; static; inline;
    class operator BitwiseXor(const L, R: TBitSet<T>): TBitSet<T>; static; inline;
    class operator LogicalNot(const Value: TBitSet<T>): TBitSet<T>; static; inline;
  end;

  TBitSetHelper = record helper for TBitSet
  public
    class function From(const Value: UInt8): TBitSet8; overload; static; inline;
    class function From(const Value: Int8): TBitSet8; overload; static; inline;
    class function From(const Value: UInt16): TBitSet16; overload; static; inline;
    class function From(const Value: Int16): TBitSet16; overload; static; inline;
    class function From(const Value: UInt32): TBitSet32; overload; static; inline;
    class function From(const Value: Int32): TBitSet32; overload; static; inline;
    class function From(const Value: UInt64): TBitSet64; overload; static; inline;
    class function From(const Value: Int64): TBitSet64; overload; static; inline;
  end;

implementation

{ TBitSetEnumeratorBase }

function TBitSetEnumeratorBase.GetCurrent: TObject;
begin
  Result := nil;
end;

function TBitSetEnumeratorBase.MoveNext: Boolean;
begin
  Result := False;
end;

procedure TBitSetEnumeratorBase.Reset;
begin

end;

{ TBitSetEnumerator }

constructor TBitSetEnumerator.Create(const Bits: TBitSet);
begin
  FBits := Bits;
  FIndex := 0;
end;

function TBitSetEnumerator.GetCurrent: TBitInSet;
begin
  Result.Position := FIndex - 1;
  Result.IsSet := FBits[FIndex - 1];
end;

function TBitSetEnumerator.MoveNext: Boolean;
begin
  Result := (FBits.Count > 0) and (FIndex < FBits.Count);
  if Result then
    Inc(FIndex);
end;

procedure TBitSetEnumerator.Reset;
begin
  FIndex := 0;
end;

{ TBitSet8Enumerator }

constructor TBitSet8Enumerator.Create(const Bits: TBitSet8);
begin
  FBits := Bits;
  FIndex := 0;
end;

function TBitSet8Enumerator.GetCurrent: TBitInSet;
begin
  Result.Position := FIndex - 1;
  Result.IsSet := FBits[FIndex - 1];
end;

function TBitSet8Enumerator.MoveNext: Boolean;
begin
  Result := (FBits.Count > 0) and (FIndex < FBits.Count);
  if Result then
    Inc(FIndex);
end;

procedure TBitSet8Enumerator.Reset;
begin
  FIndex := 0;
end;

{ TBitSet16Enumerator }

constructor TBitSet16Enumerator.Create(const Bits: TBitSet16);
begin
  FBits := Bits;
  FIndex := 0;
end;

function TBitSet16Enumerator.GetCurrent: TBitInSet;
begin
  Result.Position := FIndex - 1;
  Result.IsSet := FBits[FIndex - 1];
end;

function TBitSet16Enumerator.MoveNext: Boolean;
begin
  Result := (FBits.Count > 0) and (FIndex < FBits.Count);
  if Result then
    Inc(FIndex);
end;

procedure TBitSet16Enumerator.Reset;
begin
  FIndex := 0;
end;

{ TBitSet32Enumerator }

constructor TBitSet32Enumerator.Create(const Bits: TBitSet32);
begin
  FBits := Bits;
  FIndex := 0;
end;

function TBitSet32Enumerator.GetCurrent: TBitInSet;
begin
  Result.Position := FIndex - 1;
  Result.IsSet := FBits[FIndex - 1];
end;

function TBitSet32Enumerator.MoveNext: Boolean;
begin
  Result := (FBits.Count > 0) and (FIndex < FBits.Count);
  if Result then
    Inc(FIndex);
end;

procedure TBitSet32Enumerator.Reset;
begin
  FIndex := 0;
end;

{ TBitSet64Enumerator }

constructor TBitSet64Enumerator.Create(const Bits: TBitSet64);
begin
  FBits := Bits;
  FIndex := 0;
end;

function TBitSet64Enumerator.GetCurrent: TBitInSet;
begin
  Result.Position := FIndex;
  Result.IsSet := FBits[FIndex - 1];
end;

function TBitSet64Enumerator.MoveNext: Boolean;
begin
  Result := (FBits.Count > 0) and (FIndex < FBits.Count);
  if Result then
    Inc(FIndex);
end;

procedure TBitSet64Enumerator.Reset;
begin
  FIndex := 0;
end;

{ TBitSet }

constructor TBitSet.Create(Count: NativeUInt);
begin
  FCount := Count;
  FLength := (Count + 63) shr 6;
  FSize := (Count + 7) shr 3;
  SetLength(FBits, FLength);
end;

constructor TBitSet.Create(Data: Pointer; Count: NativeUInt);
begin
  Create(Count);
  Load(Data);
end;

function TBitSet.GetEnumerator: IBitSetEnumerator;
begin
  Result := TBitSetEnumerator.Create(Self);
end;

function TBitSet.GetBit(const Pos: NativeUInt): Boolean;
begin
  Result := (FBits[(Pos and -64) shr 6] and BitValue[Pos and 63]) <> 0;
end;

procedure TBitSet.SetBit(const Pos: NativeUInt; const Value: Boolean);
begin
  var Index := (Pos and -64) shr 6;
  if Value then
    FBits[Index] := FBits[Index] or BitValue[Pos and 63]
  else
    FBits[Index] := FBits[Index] and not BitValue[Pos and 63];
end;

procedure TBitSet.Load(Data: Pointer);
begin
  if Count > 0 then
  begin
    FBits[FLength - 1] := 0;
    Move(Data^, Pointer(FBits)^, FSize);
  end;
end;

procedure TBitSet.Save(Data: Pointer);
begin
  if Count > 0 then
  begin
    Move(Pointer(FBits)^, Data^, FSize);
  end;
end;

function TBitSet.All: Boolean;
begin
  for var I := 0 to FLength - 2 do
    if FBits[I] <> UInt64.MaxValue then
      Exit(False);

  Result := FBits[FLength - 1] = SignificantBitMask[(Count - 1) and 63];
end;

function TBitSet.Any: Boolean;
begin
  for var I := 0 to FLength - 1 do
    if FBits[I] <> 0 then
      Exit(True);
  Result := False;
end;

function TBitSet.Flip(const Pos: NativeUInt): TBitSet;
begin
  Result := Self;
  Result[Pos] := not Result[Pos];
end;

function TBitSet.Flip: TBitSet;
begin
  Result := not Self;
end;

function TBitSet.&Set(const Pos: NativeUInt): TBitSet;
begin
  Result := Self;
  Result[Pos] := True;
end;

function TBitSet.&Set: TBitSet;
begin
  Result := Self;
  for var I := 0 to FLength - 2 do
    Result.FBits[I] := UInt64.MaxValue;

  Result.FBits[FLength - 1] := SignificantBitMask[(Count - 1) and 63];
end;

function TBitSet.None: Boolean;
begin
  for var I := 0 to FLength - 1 do
    if FBits[I] <> 0 then
      Exit(False);
  Result := True;
end;

function TBitSet.Reset(const Pos: NativeUInt): TBitSet;
begin
  Result := Self;
  Result[Pos] := False;
end;

function TBitSet.Reset: TBitSet;
begin
  for var I := 0 to FLength - 1 do
    FBits[I] := 0;
end;

function TBitSet.ToString: string;
const
  cBit: array[Boolean] of Char = ('0', '1');
begin
  SetLength(Result, Count);
  for var I := 0 to Count - 1 do
    Result[Count - I] := cBit[Bit[I]];

end;

class operator TBitSet.Explicit(const Value: Byte): TBitSet;
begin
  Result.FCount := 8;
  Result.FSize := 8;
  Result.FLength := 1;
  SetLength(Result.FBits, 1);
  Result.FBits[0] := Value;
end;

class operator TBitSet.Explicit(const Value: Word): TBitSet;
begin
  Result.FCount := 16;
  Result.FSize := 8;
  Result.FLength := 1;
  SetLength(Result.FBits, 1);
  Result.FBits[0] := Value;
end;

class operator TBitSet.Explicit(const Value: UInt32): TBitSet;
begin
  Result.FCount := 32;
  Result.FSize := 8;
  Result.FLength := 1;
  SetLength(Result.FBits, 1);
  Result.FBits[0] := Value;
end;

class operator TBitSet.Explicit(const Value: UInt64): TBitSet;
begin
  Result.FCount := 64;
  Result.FSize := 8;
  Result.FLength := 1;
  SetLength(Result.FBits, 1);
  Result.FBits[0] := Value;
end;

class operator TBitSet.Explicit(const Value: TBitSet): Byte;
begin
  Result := Int64Rec(Value.FBits[0]).Bytes[0];
end;

class operator TBitSet.Explicit(const Value: TBitSet): Word;
begin
  Result := Int64Rec(Value.FBits[0]).Words[0];
end;

class operator TBitSet.Explicit(const Value: TBitSet): UInt32;
begin
  Result := Int64Rec(Value.FBits[0]).Lo;
end;

class operator TBitSet.Explicit(const Value: TBitSet): UInt64;
begin
  Result := Value.FBits[0];
end;

class operator TBitSet.BitwiseAnd(const L, R: TBitSet): TBitSet;
begin
  Result := L;
  if Result.FCount < R.FCount then
  begin
    Result.FSize := R.FSize;
    Result.FCount := R.FCount;
    Result.FLength := R.FLength;
    SetLength(Result.FBits, R.FLength);
  end;

  for var I := 0 to R.FLength - 1 do
    Result.FBits[I] := L.FBits[I] and R.FBits[I];

  for var I := R.FLength to L.FLength - 1 do
    Result.FBits[I] := 0;
end;

class operator TBitSet.BitwiseOr(const L, R: TBitSet): TBitSet;
begin
  Result := L;
  if Result.FCount < R.FCount then
  begin
    Result.FSize := R.FSize;
    Result.FCount := R.FCount;
    Result.FLength := R.FLength;
    SetLength(Result.FBits, R.FLength);
  end;

  for var I := 0 to R.FLength - 1 do
    Result.FBits[I] := L.FBits[I] or R.FBits[I];
end;

class operator TBitSet.BitwiseXor(const L, R: TBitSet): TBitSet;
begin
  Result := L;
  if Result.FCount < R.FCount then
  begin
    Result.FSize := R.FSize;
    Result.FCount := R.FCount;
    Result.FLength := R.FLength;
    SetLength(Result.FBits, R.FLength);
  end;

  for var I := 0 to R.FLength - 1 do
    Result.FBits[I] := L.FBits[I] xor R.FBits[I];

  for var I := R.FLength to L.FLength - 1 do
    Result.FBits[I] := L.FBits[I] xor 0;
end;

class operator TBitSet.LogicalNot(const Value: TBitSet): TBitSet;
begin
  Result := Value;
  for var I := 0 to Result.FLength - 1 do
    Result.FBits[I] := not Result.FBits[I];
end;

class operator TBitSet.Equal(const L, R: TBitSet): Boolean;
begin
  if L.FLength = R.FLength then
  begin
    if L.FLength = 0 then
      Exit(True);

    Result := L.FBits[0] = R.FBits[0];
    if Result then
      for var I := 1 to L.FLength - 1 do
        if L.FBits[I] <> R.FBits[I] then
          Exit(False);
  end
  else if L.FLength > R.FLength then
  begin
    for var I := 0 to R.FLength - 1 do
      if L.FBits[I] <> R.FBits[I] then
        Exit(False);

    for var I := R.FLength to L.FLength - 1 do
      if L.FBits[I] <> 0 then
        Exit(False);
  end
  else
  begin
    for var I := 0 to L.FLength - 1 do
      if L.FBits[I] <> R.FBits[I] then
        Exit(False);

    for var I := L.FLength to R.FLength - 1 do
      if R.FBits[I] <> 0 then
        Exit(False);
  end;

  Result := True;
end;

class operator TBitSet.NotEqual(const L, R: TBitSet): Boolean;
begin
  Result := not (L = R);
end;

{ TBitSet8 }

constructor TBitSet8.Create(Value: UInt8);
begin
  FBits := Value;
end;

function TBitSet8.GetBit(const Pos: NativeUInt): Boolean;
begin
  Result := (FBits and BitValue[Pos]) <> 0;
end;

procedure TBitSet8.SetBit(const Pos: NativeUInt; const Value: Boolean);
begin
  if Value then
    FBits := FBits or BitValue[Pos]
  else
    FBits := FBits and not BitValue[Pos];
end;

function TBitSet8.GetEnumerator: IBitSetEnumerator;
begin
  Result := TBitSet8Enumerator.Create(Self);
end;

class operator TBitSet8.Implicit(const Value: TBitSet8): UInt8;
begin
  Result := Value.FBits;
end;

function TBitSet8.All: Boolean;
begin
  Result := FBits = Byte.MaxValue;
end;

function TBitSet8.Any: Boolean;
begin
  Result := FBits <> 0;
end;

function TBitSet8.Flip(const Pos: NativeUInt): TBitSet8;
begin
  Result := Self;
  Result[Pos] := not Result[Pos];
end;

function TBitSet8.Flip: TBitSet8;
begin
  Result.FBits := not FBits;
end;

function TBitSet8.&Set(const Pos: NativeUInt): TBitSet8;
begin
  Result := Self;
  Result[Pos] := True;
end;

function TBitSet8.&Set: TBitSet8;
begin
  Result := Self;
  Result.FBits := Byte.MaxValue;
end;

function TBitSet8.None: Boolean;
begin
  Result := FBits = 0;
end;

function TBitSet8.Reset(const Pos: NativeUInt): TBitSet8;
begin
  Result := Self;
  Result[Pos] := False;
end;

function TBitSet8.Reset: TBitSet8;
begin
  FBits := 0;
end;

function TBitSet8.ToString: string;
const
  cBit: array[Boolean] of Char = ('0', '1');
begin
  SetLength(Result, 8);
  for var I := 0 to 7 do
    Result[8 - I] := cBit[Bit[I]];
end;

class operator TBitSet8.BitwiseAnd(const L, R: TBitSet8): TBitSet8;
begin
  Result.FBits := L.FBits and R.FBits;
end;

class operator TBitSet8.BitwiseOr(const L, R: TBitSet8): TBitSet8;
begin
  Result.FBits := L.FBits or R.FBits;
end;

class operator TBitSet8.BitwiseXor(const L, R: TBitSet8): TBitSet8;
begin
  Result.FBits := L.FBits xor R.FBits;
end;

class operator TBitSet8.LogicalNot(const Value: TBitSet8): TBitSet8;
begin
  Result.FBits := not Value.FBits;
end;

class operator TBitSet8.Equal(const L, R: TBitSet8): Boolean;
begin
  Result := L.FBits = R.FBits;
end;

class operator TBitSet8.NotEqual(const L, R: TBitSet8): Boolean;
begin
  Result := L.FBits <> R.FBits;
end;

{ TBitSet16 }

constructor TBitSet16.Create(Value: UInt16);
begin
  FBits := Value;
end;

function TBitSet16.GetBit(const Pos: NativeUInt): Boolean;
begin
  Result := (FBits and BitValue[Pos]) <> 0;
end;

procedure TBitSet16.SetBit(const Pos: NativeUInt; const Value: Boolean);
begin
  if Value then
    FBits := FBits or BitValue[Pos]
  else
    FBits := FBits and not BitValue[Pos];
end;

function TBitSet16.GetEnumerator: IBitSetEnumerator;
begin
  Result := TBitSet16Enumerator.Create(Self);
end;

class operator TBitSet16.Implicit(const Value: TBitSet16): UInt16;
begin
  Result := Value.FBits;
end;

class operator TBitSet16.Explicit(const Value: TBitSet16): TBitSet8;
begin
  Result.FBits := WordRec(Value).Lo;
end;

function TBitSet16.All: Boolean;
begin
  Result := FBits = Word.MaxValue;
end;

function TBitSet16.Any: Boolean;
begin
  Result := FBits <> 0;
end;

function TBitSet16.Flip(const Pos: NativeUInt): TBitSet16;
begin
  Result := Self;
  Result[Pos] := not Result[Pos];
end;

function TBitSet16.Flip: TBitSet16;
begin
  Result.FBits := not FBits;
end;

function TBitSet16.&Set(const Pos: NativeUInt): TBitSet16;
begin
  Result := Self;
  Result[Pos] := True;
end;

function TBitSet16.&Set: TBitSet16;
begin
  Result := Self;
  Result.FBits := Word.MaxValue;
end;

function TBitSet16.None: Boolean;
begin
  Result := FBits = 0;
end;

function TBitSet16.Reset(const Pos: NativeUInt): TBitSet16;
begin
  Result := Self;
  Result[Pos] := False;
end;

function TBitSet16.Reset: TBitSet16;
begin
  FBits := 0;
end;

function TBitSet16.ToString: string;
const
  cBit: array[Boolean] of Char = ('0', '1');
begin
  SetLength(Result, 16);
  for var I := 0 to 15 do
    Result[16 - I] := cBit[Bit[I]];
end;

class operator TBitSet16.BitwiseAnd(const L, R: TBitSet16): TBitSet16;
begin
  Result.FBits := L.FBits and R.FBits;
end;

class operator TBitSet16.BitwiseOr(const L, R: TBitSet16): TBitSet16;
begin
  Result.FBits := L.FBits or R.FBits;
end;

class operator TBitSet16.BitwiseXor(const L, R: TBitSet16): TBitSet16;
begin
  Result.FBits := L.FBits xor R.FBits;
end;

class operator TBitSet16.LogicalNot(const Value: TBitSet16): TBitSet16;
begin
  Result.FBits := not Value.FBits;
end;

class operator TBitSet16.Equal(const L, R: TBitSet16): Boolean;
begin
  Result := L.FBits = R.FBits;
end;

class operator TBitSet16.NotEqual(const L, R: TBitSet16): Boolean;
begin
  Result := L.FBits <> R.FBits;
end;

{ TBitSet32 }

constructor TBitSet32.Create(Value: UInt32);
begin
  FBits := Value;
end;

function TBitSet32.GetBit(const Pos: NativeUInt): Boolean;
begin
  Result := (FBits and BitValue[Pos]) <> 0;
end;

procedure TBitSet32.SetBit(const Pos: NativeUInt; const Value: Boolean);
begin
  if Value then
    FBits := FBits or BitValue[Pos]
  else
    FBits := FBits and not BitValue[Pos];
end;

function TBitSet32.GetEnumerator: IBitSetEnumerator;
begin
  Result := TBitSet32Enumerator.Create(Self);
end;

class operator TBitSet32.Implicit(const Value: TBitSet32): UInt32;
begin
  Result := Value.FBits;
end;

class operator TBitSet32.Explicit(const Value: TBitSet32): TBitSet16;
begin
  Result.FBits := LongRec(Value).Lo;
end;

class operator TBitSet32.Explicit(const Value: TBitSet32): TBitSet8;
begin
  Result.FBits := LongRec(Value).Bytes[0];
end;

function TBitSet32.All: Boolean;
begin
  Result := FBits = UInt32.MaxValue;
end;

function TBitSet32.Any: Boolean;
begin
  Result := FBits <> 0;
end;

function TBitSet32.Flip(const Pos: NativeUInt): TBitSet32;
begin
  Result := Self;
  Result[Pos] := not Result[Pos];
end;

function TBitSet32.Flip: TBitSet32;
begin
  Result.FBits := not FBits;
end;

function TBitSet32.&Set(const Pos: NativeUInt): TBitSet32;
begin
  Result := Self;
  Result[Pos] := True;
end;

function TBitSet32.&Set: TBitSet32;
begin
  Result := Self;
  Result.FBits := UInt32.MaxValue;
end;

function TBitSet32.None: Boolean;
begin
  Result := FBits = 0;
end;

function TBitSet32.Reset(const Pos: NativeUInt): TBitSet32;
begin
  Result := Self;
  Result[Pos] := False;
end;

function TBitSet32.Reset: TBitSet32;
begin
  FBits := 0;
end;

function TBitSet32.ToString: string;
const
  cBit: array[Boolean] of Char = ('0', '1');
begin
  SetLength(Result, 32);
  for var I := 0 to 31 do
    Result[32 - I] := cBit[Bit[I]];
end;

class operator TBitSet32.BitwiseAnd(const L, R: TBitSet32): TBitSet32;
begin
  Result.FBits := L.FBits and R.FBits;
end;

class operator TBitSet32.BitwiseOr(const L, R: TBitSet32): TBitSet32;
begin
  Result.FBits := L.FBits or R.FBits;
end;

class operator TBitSet32.BitwiseXor(const L, R: TBitSet32): TBitSet32;
begin
  Result.FBits := L.FBits xor R.FBits;
end;

class operator TBitSet32.LogicalNot(const Value: TBitSet32): TBitSet32;
begin
  Result.FBits := not Value.FBits;
end;

class operator TBitSet32.Equal(const L, R: TBitSet32): Boolean;
begin
  Result := L.FBits = R.FBits;
end;

class operator TBitSet32.NotEqual(const L, R: TBitSet32): Boolean;
begin
  Result := L.FBits <> R.FBits;
end;

{ TBitSet64 }

constructor TBitSet64.Create(Value: UInt64);
begin
  FBits := Value;
end;

function TBitSet64.GetBit(const Pos: NativeUInt): Boolean;
begin
  Result := (FBits and BitValue[Pos]) <> 0;
end;

procedure TBitSet64.SetBit(const Pos: NativeUInt; const Value: Boolean);
begin
  if Value then
    FBits := FBits or BitValue[Pos]
  else
    FBits := FBits and not BitValue[Pos];
end;

function TBitSet64.GetEnumerator: IBitSetEnumerator;
begin
  Result := TBitSet64Enumerator.Create(Self);
end;

class operator TBitSet64.Implicit(const Value: TBitSet64): UInt64;
begin
  Result := Value.FBits;
end;

class operator TBitSet64.Explicit(const Value: TBitSet64): TBitSet8;
begin
  Result.FBits := Int64Rec(Value).Bytes[0];
end;

class operator TBitSet64.Explicit(const Value: TBitSet64): TBitSet16;
begin
  Result.FBits := Int64Rec(Value).Words[0];
end;

class operator TBitSet64.Explicit(const Value: TBitSet64): TBitSet32;
begin
  Result.FBits := Int64Rec(Value).Lo;
end;

function TBitSet64.All: Boolean;
begin
  Result := FBits = UInt64.MaxValue;
end;

function TBitSet64.Any: Boolean;
begin
  Result := FBits <> 0;
end;

function TBitSet64.Flip(const Pos: NativeUInt): TBitSet64;
begin
  Result := Self;
  Result[Pos] := not Result[Pos];
end;

function TBitSet64.Flip: TBitSet64;
begin
  Result := not Self;
end;

function TBitSet64.&Set(const Pos: NativeUInt): TBitSet64;
begin
  Result := Self;
  Result[Pos] := True;
end;

function TBitSet64.&Set: TBitSet64;
begin
  Result := Self;
  Result.FBits := UInt64.MaxValue;
end;

function TBitSet64.None: Boolean;
begin
  Result := FBits = 0;
end;

function TBitSet64.Reset(const Pos: NativeUInt): TBitSet64;
begin
  Result := Self;
  Result[Pos] := False;
end;

function TBitSet64.Reset: TBitSet64;
begin
  FBits := 0;
end;

function TBitSet64.ToString: string;
const
  cBit: array[Boolean] of Char = ('0', '1');
begin
  SetLength(Result, 64);
  for var I := 0 to 63 do
    Result[64 - I] := cBit[Bit[I]];
end;

class operator TBitSet64.BitwiseAnd(const L, R: TBitSet64): TBitSet64;
begin
  Result.FBits := L.FBits and R.FBits;
end;

class operator TBitSet64.BitwiseOr(const L, R: TBitSet64): TBitSet64;
begin
  Result.FBits := L.FBits or R.FBits;
end;

class operator TBitSet64.BitwiseXor(const L, R: TBitSet64): TBitSet64;
begin
  Result.FBits := L.FBits xor R.FBits;
end;

class operator TBitSet64.LogicalNot(const Value: TBitSet64): TBitSet64;
begin
  Result.FBits := not Value.FBits;
end;

class operator TBitSet64.Equal(const L, R: TBitSet64): Boolean;
begin
  Result := L.FBits = R.FBits;
end;

class operator TBitSet64.NotEqual(const L, R: TBitSet64): Boolean;
begin
  Result := L.FBits <> R.FBits;
end;

{ TBitSet<T> }

function TBitSet<T>.GetBit(const Pos: NativeUInt): Boolean;
begin
  case Size of
    1: Result := TBitSet8(PUInt8(@FBits)^)[Pos];
    2: Result := TBitSet16(PUInt16(@FBits)^)[Pos];
    4: Result := TBitSet32(PUInt32(@FBits)^)[Pos];
    8: Result := TBitSet64(PUInt64(@FBits)^)[Pos];
  else Result := TBitSet.Create(@FBits, Count)[Pos];
  end;
end;

function TBitSet<T>.GetEnumerator: IBitSetEnumerator;
begin
  case Size of
    1: Result := TBitSet8(PUInt8(@FBits)^).GetEnumerator;
    2: Result := TBitSet16(PUInt16(@FBits)^).GetEnumerator;
    4: Result := TBitSet32(PUInt32(@FBits)^).GetEnumerator;
    8: Result := TBitSet64(PUInt64(@FBits)^).GetEnumerator;
  else Result := TBitSet.Create(@FBits, Count).GetEnumerator;
  end;
end;

procedure TBitSet<T>.SetBit(const Pos: NativeUInt; const Value: Boolean);
begin
  case Size of
    1: TBitSet8(PUInt8(@FBits)^)[Pos] := Value;
    2: TBitSet16(PUInt16(@FBits)^)[Pos] := Value;
    4: TBitSet32(PUInt32(@FBits)^)[Pos] := Value;
    8: TBitSet64(PUInt64(@FBits)^)[Pos] := Value;
  else TBitSet.Create(@FBits, Count)[Pos] := Value;
  end;
end;

function TBitSet<T>.All: Boolean;
begin
  case Size of
    1: Result := TBitSet8(PUInt8(@FBits)^).All;
    2: Result := TBitSet16(PUInt16(@FBits)^).All;
    4: Result := TBitSet32(PUInt32(@FBits)^).All;
    8: Result := TBitSet64(PUInt64(@FBits)^).All;
  else Result := TBitSet.Create(@FBits, Count).All;
  end;
end;

function TBitSet<T>.Any: Boolean;
begin
  case Size of
    1: Result := TBitSet8(PUInt8(@FBits)^).Any;
    2: Result := TBitSet16(PUInt16(@FBits)^).Any;
    4: Result := TBitSet32(PUInt32(@FBits)^).Any;
    8: Result := TBitSet64(PUInt64(@FBits)^).Any;
  else Result := TBitSet.Create(@FBits, Count).Any;
  end;
end;

function TBitSet<T>.Flip: TBitSet<T>;
begin
  case Size of
    1: PUInt8(@Result.FBits)^ := TBitSet8(PUInt8(@FBits)^).Flip.FBits;
    2: PUInt16(@Result.FBits)^ := TBitSet16(PUInt16(@FBits)^).Flip.FBits;
    4: PUInt32(@Result.FBits)^ := TBitSet32(PUInt32(@FBits)^).Flip.FBits;
    8: PUInt64(@Result.FBits)^ := TBitSet64(PUInt64(@FBits)^).Flip.FBits;
  else Move(TBitSet.Create(@FBits, Count).Flip.FBits[0], Result.FBits, Size);
  end;
end;

function TBitSet<T>.Flip(const Pos: NativeUInt): TBitSet<T>;
begin
  case Size of
    1: PUInt8(@Result.FBits)^ := TBitSet8(PUInt8(@FBits)^).Flip(Pos).FBits;
    2: PUInt16(@Result.FBits)^ := TBitSet16(PUInt16(@FBits)^).Flip(Pos).FBits;
    4: PUInt32(@Result.FBits)^ := TBitSet32(PUInt32(@FBits)^).Flip(Pos).FBits;
    8: PUInt64(@Result.FBits)^ := TBitSet64(PUInt64(@FBits)^).Flip(Pos).FBits;
  else Move(TBitSet.Create(@FBits, Count).Flip(Pos).FBits[0], Result.FBits, Size);
  end;
end;

function TBitSet<T>.None: Boolean;
begin
  case Size of
    1: Result := TBitSet8(PUInt8(@FBits)^).None;
    2: Result := TBitSet16(PUInt16(@FBits)^).None;
    4: Result := TBitSet32(PUInt32(@FBits)^).None;
    8: Result := TBitSet64(PUInt64(@FBits)^).None;
  else Result := TBitSet.Create(@FBits, Count).None;
  end;
end;

function TBitSet<T>.Reset: TBitSet<T>;
begin
  case Size of
    1: PUInt8(@Result.FBits)^ := TBitSet8(PUInt8(@FBits)^).Reset.FBits;
    2: PUInt16(@Result.FBits)^ := TBitSet16(PUInt16(@FBits)^).Reset.FBits;
    4: PUInt32(@Result.FBits)^ := TBitSet32(PUInt32(@FBits)^).Reset.FBits;
    8: PUInt64(@Result.FBits)^ := TBitSet64(PUInt64(@FBits)^).Reset.FBits;
  else Move(TBitSet.Create(@FBits, Count).Reset.FBits[0], Result.FBits, Size);
  end;
end;

function TBitSet<T>.Reset(const Pos: NativeUInt): TBitSet<T>;
begin
  case Size of
    1: PUInt8(@Result.FBits)^ := TBitSet8(PUInt8(@FBits)^).Reset(Pos).FBits;
    2: PUInt16(@Result.FBits)^ := TBitSet16(PUInt16(@FBits)^).Reset(Pos).FBits;
    4: PUInt32(@Result.FBits)^ := TBitSet32(PUInt32(@FBits)^).Reset(Pos).FBits;
    8: PUInt64(@Result.FBits)^ := TBitSet64(PUInt64(@FBits)^).Reset(Pos).FBits;
  else Move(TBitSet.Create(@FBits, Count).Reset(Pos).FBits[0], Result.FBits, Size);
  end;
end;

function TBitSet<T>.&Set(const Pos: NativeUInt): TBitSet<T>;
begin
  case Size of
    1: PUInt8(@Result.FBits)^ := TBitSet8(PUInt8(@FBits)^).&Set(Pos).FBits;
    2: PUInt16(@Result.FBits)^ := TBitSet16(PUInt16(@FBits)^).&Set(Pos).FBits;
    4: PUInt32(@Result.FBits)^ := TBitSet32(PUInt32(@FBits)^).&Set(Pos).FBits;
    8: PUInt64(@Result.FBits)^ := TBitSet64(PUInt64(@FBits)^).&Set(Pos).FBits;
  else Move(TBitSet.Create(@FBits, Count).&Set(Pos).FBits[0], Result.FBits, Size);
  end;
end;

function TBitSet<T>.&Set: TBitSet<T>;
begin
  case Size of
    1: PUInt8(@Result.FBits)^ := TBitSet8(PUInt8(@FBits)^).&Set.FBits;
    2: PUInt16(@Result.FBits)^ := TBitSet16(PUInt16(@FBits)^).&Set.FBits;
    4: PUInt32(@Result.FBits)^ := TBitSet32(PUInt32(@FBits)^).&Set.FBits;
    8: PUInt64(@Result.FBits)^ := TBitSet64(PUInt64(@FBits)^).&Set.FBits;
  else Move(TBitSet.Create(@FBits, Count).&Set.FBits[0], Result.FBits, Size);
  end;
end;

function TBitSet<T>.ToString: string;
begin
  case Size of
    1: Result := TBitSet8(PUInt8(@FBits)^).ToString;
    2: Result := TBitSet16(PUInt16(@FBits)^).ToString;
    4: Result := TBitSet32(PUInt32(@FBits)^).ToString;
    8: Result := TBitSet64(PUInt64(@FBits)^).ToString;
  else Result := TBitSet.Create(@FBits, Count).ToString;
  end;
end;

class operator TBitSet<T>.BitwiseAnd(const L, R: TBitSet<T>): TBitSet<T>;
begin
  case Size of
    1: PUInt8(@Result.FBits)^   := TBitSet8(PUInt8(@L.FBits)^).FBits and TBitSet8(PUInt8(@R.FBits)^).FBits;
    2: PUInt16(@Result.FBits)^   := TBitSet16(PUInt16(@L.FBits)^).FBits and TBitSet16(PUInt16(@R.FBits)^).FBits;
    4: PUInt32(@Result.FBits)^ := TBitSet32(PUInt32(@L.FBits)^).FBits and TBitSet32(PUInt32(@R.FBits)^).FBits;
    8: PUInt64(@Result.FBits)^ := TBitSet64(PUInt64(@L.FBits)^).FBits and TBitSet64(PUInt64(@R.FBits)^).FBits;
  else Move((TBitSet.Create(@L.FBits, Count) and TBitSet.Create(@R.FBits, Count)).FBits[0], Result.FBits, Size);
  end;
end;

class operator TBitSet<T>.BitwiseOr(const L, R: TBitSet<T>): TBitSet<T>;
begin
  case Size of
    1: PUInt8(@Result.FBits)^   := TBitSet8(PUInt8(@L.FBits)^).FBits or TBitSet8(PUInt8(@R.FBits)^).FBits;
    2: PUInt16(@Result.FBits)^   := TBitSet16(PUInt16(@L.FBits)^).FBits or TBitSet16(PUInt16(@R.FBits)^).FBits;
    4: PUInt32(@Result.FBits)^ := TBitSet32(PUInt32(@L.FBits)^).FBits or TBitSet32(PUInt32(@R.FBits)^).FBits;
    8: PUInt64(@Result.FBits)^ := TBitSet64(PUInt64(@L.FBits)^).FBits or TBitSet64(PUInt64(@R.FBits)^).FBits;
  else Move((TBitSet.Create(@L.FBits, Count) or TBitSet.Create(@R.FBits, Count)).FBits[0], Result.FBits, Size);
  end;
end;

class operator TBitSet<T>.BitwiseXor(const L, R: TBitSet<T>): TBitSet<T>;
begin
  case Size of
    1: PUInt8(@Result.FBits)^   := TBitSet8(PUInt8(@L.FBits)^).FBits xor TBitSet8(PUInt8(@R.FBits)^).FBits;
    2: PUInt16(@Result.FBits)^   := TBitSet16(PUInt16(@L.FBits)^).FBits xor TBitSet16(PUInt16(@R.FBits)^).FBits;
    4: PUInt32(@Result.FBits)^ := TBitSet32(PUInt32(@L.FBits)^).FBits xor TBitSet32(PUInt32(@R.FBits)^).FBits;
    8: PUInt64(@Result.FBits)^ := TBitSet64(PUInt64(@L.FBits)^).FBits xor TBitSet64(PUInt64(@R.FBits)^).FBits;
  else Move((TBitSet.Create(@L.FBits, Count) xor TBitSet.Create(@R.FBits, Count)).FBits[0], Result.FBits, Size);
  end;
end;

class operator TBitSet<T>.LogicalNot(const Value: TBitSet<T>): TBitSet<T>;
begin
  case Size of
    1: PUInt8(@Result.FBits)^   := not TBitSet8(PUInt8(@Value.FBits)^).FBits;
    2: PUInt16(@Result.FBits)^   := not TBitSet16(PUInt16(@Value.FBits)^).FBits;
    4: PUInt32(@Result.FBits)^ := not TBitSet32(PUInt32(@Value.FBits)^).FBits;
    8: PUInt64(@Result.FBits)^ := not TBitSet64(PUInt64(@Value.FBits)^).FBits;
  else Move((not TBitSet.Create(@Value.FBits, Count)).FBits[0], Result.FBits, Size);
  end;
end;

class operator TBitSet<T>.Equal(const L, R: TBitSet<T>): Boolean;
begin
  Result := CompareMem(@L.FBits, @R.FBits, Size);
end;

class operator TBitSet<T>.NotEqual(const L, R: TBitSet<T>): Boolean;
begin
  Result := not CompareMem(@L.FBits, @R.FBits, Size);
end;

class operator TBitSet<T>.Implicit(const Value: TBitSet<T>): T;
begin
  Result := Value.FBits;
end;

{ TBitSetHelper }

class function TBitSetHelper.From(const Value: Int16): TBitSet16;
begin
  Result.FBits := UInt16(Value);
end;

class function TBitSetHelper.From(const Value: UInt16): TBitSet16;
begin
  Result.FBits := Value;
end;

class function TBitSetHelper.From(const Value: Int8): TBitSet8;
begin
  Result.FBits := UInt8(Value);
end;

class function TBitSetHelper.From(const Value: UInt8): TBitSet8;
begin
  Result.FBits := Value;
end;

class function TBitSetHelper.From(const Value: Int64): TBitSet64;
begin
  Result.FBits := UInt64(Value);
end;

class function TBitSetHelper.From(const Value: UInt64): TBitSet64;
begin
  Result.FBits := Value;
end;

class function TBitSetHelper.From(const Value: Int32): TBitSet32;
begin
  Result.FBits := UInt32(Value);
end;

class function TBitSetHelper.From(const Value: UInt32): TBitSet32;
begin
  Result.FBits := Value;
end;

end.
