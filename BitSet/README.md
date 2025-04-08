## BitSet
The module contains types that allow you to manipulate individual bits in the data.

TBitSet and TBitSetX types is a fixed-size sequence of bits. The sets of bits can be converted to and from strings and integers, supports bitwise AND, OR, XOR and unary NOT operators, allows Test, Set and Unset individual bits, iterate (for .. in) thorough bits.

All bitset types contains same set of methods similar to C standard library.

All operations, under individual bits, uses zero-based indexing.

## Brief
#### TBitSet
Record type represents sequence of `Count` bits. Where `Count` is set at creation time.
Supports explicit cast to/from correspoding unsigned integer types (Byte, Word, Cardinal, UInt64).

#### TBitSetX types
TBitSet8, TBitSet16, TBitSet32, TBitSet64 - set of types similar to TBitSet, but fixed size of 8, 16,32, 64 bit. Is fast as possible to work with corresponding integer types.

#### TBitSet\<T>
Represents any value of type `T` as sequence of bits. `T` - must be value type (record, ordinal, real, fixed size array...). Supports explicit cast to/from `T`.

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

#### procedure Load(Data: Pointer)
Load bitset from memory, size of referenced data must be equal to Size
    
#### procedure Save(Data: Pointer)
Save bitset to memory, size of buffer must be equal or greater then Size

#### function All: Boolean
Returns True if all bits set

#### function Any: Boolean
Returns True if any bit in sequnece is set

#### function Flip: TBitSet
Returns new bitset with inverted values of all bits.
    
#### function Flip(const Pos: NativeUInt): TBitSet
Returns new bitset with inverted bit at `Pos`.

#### function None: Boolean
Returns True if all bits not set.
    
#### function Reset: TBitSet
Returns copy of bitset and unset all bits.
    
#### function Reset(const Pos: NativeUInt): TBitSet
Returns copy of bitset and unset bit at `Pos`.
    
#### function Set: TBitSet
Returns copy of bitset and set all bits.
    
#### function Set(const Pos: NativeUInt): TBitSet
Returns copy of bitset and set bit at `Pos`.

#### function  ToString: string
A string where each bit set has a corresponding character of 1, and 0 if the bit is unset.

### Explicit casts
- Byte → TBitSet
- Word → TBitSet
- UInt32 → TBitSet
- UInt64 → TBitSet
- TBitSet → Byte
- TBitSet → Word
- TBitSet → UInt32
- TBitSet → UInt64

### Operators
- Equal
- Not Equal
- Bitwise And
- Bitwise Or
- Bitwise Xor
- Not
