## BitSet
The module contains types that allow you to manipulate individual bits in the data.

TBitSet and TBitSetX types is a fixed-size sequence of bits. The sets of bits can be converted to and from strings and integers, supports bitwise AND, OR, XOR and unary NOT operators, allows Test, Set and Unset individual bits, iterate (for .. in) thorough bits.

All bitset types contains same set of methods similar to C standard library.

All operations, under individual bits, uses zero-based indexing.


### TBitSet
Record type represents sequence of `Count` bits. Where `Count` is set at creation time.

Supports explicit cast to/from correspoding unsigned integer types (Byte, Word, Cardinal, UInt64).

### TBitSetX types
TBitSet8, TBitSet16, TBitSet32, TBitSet64 - set of types similar to TBitSet, but fixed size of 8, 16,32, 64 bit. Is fast as possible to work with corresponding integer types.

### TBitSet\<T>
Represents any value of type `T` as sequence of bits. `T` - must be value type (record, ordinal, real...). Supports explicit cast to/from `T`.

### Sample
```Pascal
WriteLn(TBitSet8(11).ToString);  // Prints 00001011
WriteLn(TBitSet16(11).ToString); // Prints 0000000000001011

var Bits := TBitSet.Create(1024); // Creates sequence of 1024 bit
Bits.&Set;                        // Set all 1024 bits
Bits[5] := False;                 // Unset 5th bit (zero based)
WriteLn(Bits.ToString);           // Prints 1024 symbols ends with: ...11011111 


