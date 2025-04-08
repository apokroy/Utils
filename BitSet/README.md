## BitSet
The module contains types that allow you to manipulate individual bits in the data.

TBitSet and TBitSetX types is a fixed-size sequence of bits. The sets of bits can be converted to and from strings and integers, supports bitwise AND, OR, XOR and unary NOT operators, allows Test, Set and Unset individual bits, iterate (for .. in) thorough bits.

All bitset types contains same set of methods similar to C standard library.

All operations, under individual bits, uses zero-based indexing.

Contains a number of types:
- [TBitSet](#TBitSet-record)

  Record type represents sequence of `Count` bits. Where `Count` is sets at creation time.
  
- TBitSetX types
  
  [TBitSet8](#TBitSet8-record), [TBitSet16](#TBitSet16-record), [TBitSet32](#TBitSet32-record), [TBitSet64](#TBitSet64-record) - set of types similar to TBitSet, but fixed size of 8, 16,32, 64 bit. Is fast as possible to work with corresponding integer types.

- [TBitSet\<T>](#TBitSett-record)
  
  Represents any value of type `T` as sequence of bits. `T` - must be value type (record, ordinal, real, fixed size array...). 

## Sample
```Pascal
WriteLn(TBitSet8.Create(11).ToString);  // Prints 00001011
WriteLn(TBitSet16.Create(11).ToString); // Prints 0000000000001011

var Bits := TBitSet.Create(1024); // Creates sequence of 1024 bit
Bits.&Set;                        // Set all 1024 bits
Bits[5] := False;                 // Unset 5th bit (zero based)
WriteLn(Bits.ToString);           // Prints 1024 symbols ends with: ...11011111 

for var Bit in Bits do
  if Bit.IsSet then
    WriteLn(Bit.Position);
```
## Types
### `TBitSet` record
Describes a type that stores a sequence consisting of a specified number of bits.

##### constructor Create(Count: NativeUInt);
Creates new set with `Count` bits, initializes all bits to 0.

##### constructor Create(Data: Pointer; Count: NativeUInt);
Creates new set with `Count` bits, initializes all bits from data pointed by `Data` argument. 

#### Properties

##### Count: NativeUInt
ReadOnly property, returns count of bits in set

##### Size: NativeUInt
ReadOnly property, returns count of bytes needed to store bits in memory

##### Bit[const Pos: NativeUInt]: Boolean; default;
Default property, to test or set bits at `Pos` (zero based).

#### Methods

##### procedure Load(Data: Pointer)
Load bitset from memory, size of referenced data must be equal to Size
    
##### procedure Save(Data: Pointer)
Save bitset to memory, size of buffer must be equal or greater then Size

##### function All: Boolean
Returns True if all bits set

##### function Any: Boolean
Returns True if any bit in sequnece is set

##### function Flip: TBitSet
Returns new bitset with inverted values of all bits.
    
##### function Flip(const Pos: NativeUInt): TBitSet
Returns new bitset with inverted bit at `Pos`.

##### function None: Boolean
Returns True if all bits not set.
    
##### function Reset: TBitSet
Returns copy of bitset and unset all bits.
    
##### function Reset(const Pos: NativeUInt): TBitSet
Returns copy of bitset and unset bit at `Pos`.
    
##### function Set: TBitSet
Returns copy of bitset and set all bits.
    
#### function Set(const Pos: NativeUInt): TBitSet
Returns copy of bitset and set bit at `Pos`.

#### function  ToString: string
A string where each bit set has a corresponding character of 1, and 0 if the bit is unset.

#### Explicit casts
- Byte → TBitSet
- Word → TBitSet
- UInt32 → TBitSet
- UInt64 → TBitSet
- TBitSet → Byte
- TBitSet → Word
- TBitSet → UInt32
- TBitSet → UInt64

#### Operators
- Equal
- Not Equal
- Bitwise And
- Bitwise Or
- Bitwise Xor
- Not

### `TBitSet8` record
TBitSet8 contains the same set of properties, methods and operators as TBitSet, but the value of `Count` is constant 8, and `Size` is 1. 

Since internal presentation of bitset is `Byte`, TBitSet8 can be casted to any single byte variable and vice versa. That allow direct bits manipulation on variables any single byte type. Also defined implicit cast to Byte.

### `TBitSet16` record
TBitSet16 contains the same set of properties, methods and operators as TBitSet, but the value of `Count` is constant 16, and `Size` is 2. 

Since internal presentation of bitset is `Word`, TBitSet16 can be casted to any two bytes variable and vice versa. That allow direct bits manipulation on variables any two bytes type. Also defined implicit cast to Word and explicit cast to TBitSet8.

### `TBitSet32` record
TBitSet32 contains the same set of properties, methods and operators as TBitSet, but the value of `Count` is constant 32, and `Size` is 4. 

Since internal presentation of bitset is `UInt32`, TBitSet32 can be casted to any four bytes variable and vice versa. That allow direct bits manipulation on variables any four bytes type. Also defined implicit cast to Cardinal and explicit cast to TBitSet8, TBitSet16.

### `TBitSet64` record
TBitSet64 contains the same set of properties, methods and operators as TBitSet, but the value of `Count` is constant 64, and `Size` is 8. 

Since internal presentation of bitset is `UInt64`, TBitSet64 can be casted to any eight bytes variable and vice versa. That allow direct bits manipulation on variables any eight bytes type. Also defined implicit cast to UInt64 and explicit cast to TBitSet8, TBitSet16, TBitSet32.

### `TBitSet<T>` record
Generic record type, designed to work with any value type in the form of a sequence of bits. `TBitSet<T>` contains the same set of properties, methods and operators as `TBitSet`, but the value of `Count` is fixed to `SizeOf(T) * 8`, and `Size` to `SizeOf(T)`.

Since internal presentation of bitset is `T`, `TBitSet<T>` can be casted to any variable of type `T` and vice versa. That allow direct bits manipulation on variables of `T` type. Also defined implicit cast to `T`.



