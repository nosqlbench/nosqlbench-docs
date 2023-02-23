---
title: general functions
weight: 20
---

These functions have no particular category, so they ended up here by default.

## Add

Adds a value to the input.

- double -> Add(double: addend) -> double

- long -> Add(int: addend) -> int

- long -> Add(long: addend) -> long

- int -> Add(int: addend) -> int
  - *example:* `Add(23)`
  - *adds integer 23 to the input integer value*

## AddCycleRange

Adds a cycle range to the input, producing an increasing sawtooth-like output.

- long -> AddCycleRange(int: maxValue) -> int

- long -> AddCycleRange(int: minValue, int: maxValue) -> int

- long -> AddCycleRange(long: maxValue) -> long

- long -> AddCycleRange(long: minValue, long: maxValue) -> long

- int -> AddCycleRange(int: maxValue) -> int

- int -> AddCycleRange(int: minValue, int: maxValue) -> int

## AddHashRange

Adds a pseudo-random value within the specified range to the input.

- long -> AddHashRange(long: maxValue) -> long

- long -> AddHashRange(long: minValue, long: maxValue) -> long

- long -> AddHashRange(int: maxValue) -> int

- long -> AddHashRange(int: minValue, int: maxValue) -> int

- int -> AddHashRange(int: maxValue) -> int

- int -> AddHashRange(int: minValue, int: maxValue) -> int

## AlphaNumericString

Create an alpha-numeric string of the specified length, character-by-character.

- long -> AlphaNumericString(int: length) -> String

## ByteBufferSizedHashed

Create a ByteBuffer from a long input based on a provided size function. As a 'Sized' function, the first argument is a function which determines the size of the resulting ByteBuffer. As a 'Hashed' function, the input value is hashed again before being used as value.

- long -> ByteBufferSizedHashed(int: size) -> java.nio.ByteBuffer
  - *example:* `ByteBufferSizedHashed(16)`
  - *Functionally identical to HashedToByteBuffer(16) but using dynamic sizing implementation*
  - *example:* `ByteBufferSizedHashed(HashRange(10, 14))`
  - *Create a ByteBuffer with variable limit (10 to 14)*

- long -> ByteBufferSizedHashed(Object: sizeFunc) -> java.nio.ByteBuffer

## CSVFrequencySampler

Takes a CSV with sample data and generates random values based on the relative frequencies of the values in the file. The CSV file must have headers which can be used to find the named columns. I.E. take the following imaginary \`animals.csv\` file: animal,count,country puppy,1,usa puppy,2,colombia puppy,3,senegal kitten,2,colombia \`CSVFrequencySampler('animals.csv', animal)\` will return \`puppy\` or \`kitten\` randomly. \`puppy\` will be 3x more frequent than \`kitten\`. \`CSVFrequencySampler('animals.csv', country)\` will return \`usa\`, \`colombia\`, or \`senegal\` randomly. \`colombia\` will be 2x more frequent than \`usa\` or \`senegal\`. Use this function to infer frequencies of categorical values from CSVs.

- long -> CSVFrequencySampler(String: filename, String: columnName) -> String
  - *notes:* Create a sampler of strings from the given CSV file. The CSV file must have plain CSV headers
as its first line.
@param filename The name of the file to be read into the sampler buffer
@param columnName The name of the column to be sampled

  - *example:* `CSVFrequencySampler('values.csv','modelno')`
  - *Read values.csv, count the frequency of values in 'modelno' column, and sample from this column proportionally*

## CSVSampler

This function is a toolkit version of the {@link WeightedStringsFromCSV} function. It is more capable and should be the preferred function for alias sampling over any CSV data. This sampler uses a named column in the CSV data as the value. This is also referred to as the *labelColumn* . The frequency of this label depends on the weight assigned to it in another named CSV column, known as the *weightColumn* .

### Combining duplicate labels

When you have CSV data which is not organized around the specific identifier that you want to sample by, you can use some combining functions to tabulate these prior to sampling. In that case, you can use any of "sum", "avg", "count", "min", or "max" as the reducing function on the value in the weight column. If none are specified, then "sum" is used by default. All modes except "count" and "name" require a valid weight column to be specified.

* sum, avg, min, max - takes the given stat for the weight of each distinct label
* count - takes the number of occurrences of a given label as the weight
* name - sets the weight of all distinct labels to 1.0d

### Map vs Hash mode

As with some of the other statistical functions, you can use this one to pick through the sample values by using the *map* mode. This is distinct from the default *hash* mode. When map mode is used, the values will appear monotonically as you scan through the unit interval of all long values. Specifically, 0L represents 0.0d in the unit interval on input, and Long.MAX_VALUE represents 1.0 on the unit interval.) This mode is only recommended for advanced scenarios and should otherwise be avoided. You will know if you need this mode.

- long -> CSVSampler(String: labelColumn, String: weightColumn, String[]...: data) -> String
  - *notes:* Build an efficient O(1) sampler for the given column values with respect to the weights,
combining equal values by summing the weights.

@param labelColumn   The CSV column name containing the value
@param weightColumn  The CSV column name containing a double weight
@param data Sampling modes or file names. Any of map, hash, sum, avg, count are taken
            as configuration modes, and all others are taken as CSV filenames.

  - *example:* `CSVSampler('USPS','n/a','name','census_state_abbrev')`
  - **

## CharBufImage

Builds a shared text image in memory and samples from it pseudo-randomly with hashing. The characters provided can be listed like a string (abc123), or can include range specifiers like a hyphen (a-zA-Z0-9). These characters are used to build an image of the specified size in memory that is sampled from according to the size function. The extracted value is sized according to either a provided function, a size range, or otherwise the whole image. The image can be varied between tests if you want by specifying a seed value. If no seed value is specified, then the image length is used also as a seed.

- long -> CharBufImage(int: size) -> java.nio.CharBuffer
  - *notes:* Shortcut constructor for building a simple text image
from A-Z, a-z, 0-9 and a space, of the specified size.
When this function is used, it always returns the full image
if constructed in this way.
@param size length in characters of the image.


- long -> CharBufImage(Object: charsFunc, int: imgsize) -> java.nio.CharBuffer
  - *notes:* This is the same as {@link CharBufImage(Object,int,Object)} except that the
extracted sample length is fixed to the buffer size, thus the function will
always return the full buffer.
@param charsFunc The function which produces objects, which toString() is used to collect their input
@param imgsize The size of the CharBuffer to build at startup


- long -> CharBufImage(Object: charsFunc, int: imgsize, Object: sizespec) -> java.nio.CharBuffer
  - *notes:* This is the same as {@link CharBufImage(Object, int, Object, long)} excep that
the seed is defaulted to 0L
@param charsFunc The function which produces objects, which toString() is used to collect their input
@param imgsize The size of the CharBuffer to build at startup
@param sizespec The specifier for how long samples should be. If this is a number, then it is static. If
                it is a function, then the size is determined for each call.


- long -> CharBufImage(Object: charsFunc, int: imgsize, Object: sizespec, long: seed) -> java.nio.CharBuffer
  - *notes:* Create a CharBuffer full of the contents of the results of calling a source
function until it is full. Then allow it to be sampled with random extracts
as determined by the sizespec.
@param charsFunc The function which produces objects, which toString() is used to collect their input
@param imgsize The size of the CharBuffer to build at startup
@param sizespec The specifier for how long samples should be. If this is a number, then it is static. If
                it is a function, then the size is determined for each call.
@param seed      A seed that can be used to change up the rendered content.


## CharBufferExtract

Create a CharBuffer from the first function, and then sample data from that buffer according to the size function. The initFunction can be given as simply a size, in which case ByteBufferSizedHash is used with Hex String conversion. If the size function yields a size larger than the available buffer size, then it is lowered to that size automatically. If it is lower, then a random offset is used within the buffer image. This function behaves slightly differently than most in that it creates and caches as source byte buffer during initialization.

- long -> CharBufferExtract(Object: initFunc, Object: sizeFunc) -> java.nio.CharBuffer

## Clamp

Clamp the output values to be at least the minimum value and at most the maximum value.

- double -> Clamp(double: min, double: max) -> double
  - *example:* `Clamp(1.0D,9.0D)`
  - *clamp output values between the range [1.0D, 9.0D], inclusive*

- long -> Clamp(long: min, long: max) -> long
  - *example:* `Clamp(4L,400L)`
  - *clamp the output values in the range [4L,400L], inclusive*

- int -> Clamp(int: min, int: max) -> int
  - *example:* `Clamp(1,100)`
  - *clamp the output values in the range [1,100], inclusive*

## Combinations

Convert a numeric value into a code according to ASCII printable characters. This is useful for creating various encodings using different character ranges, etc. This mapper can map over the sequences of character ranges providing every unique combination and then wrapping around to the beginning again. It can convert between character bases with independent radix in each position. Each position in the final string takes its values from a position-specific character set, described by the shorthand in the examples below. The constructor will throw an error if the number of combinations exceeds that which can be represented in a long value. (This is a very high number).

- long -> Combinations(String: spec) -> String
  - *example:* `Combinations('A-Z;A-Z')`
  - *a two digit alphanumeric code. Wraps at 26^2*
  - *example:* `Combinations('0-9A-F')`
  - *a single hexadecimal digit*
  - *example:* `Combinations('0123456789ABCDEF')`
  - *a single hexadecimal digit*
  - *example:* `Combinations('0-9A-F;0-9A-F;0-9A-F;0-9A-F;')`
  - *two bytes of hexadecimal*
  - *example:* `Combinations('A-9')`
  - *upper case alphanumeric*

## CycleRange

Yields a value within a specified range, which rolls over continuously.

- long -> CycleRange(long: maxValue) -> long

- long -> CycleRange(long: minValue, long: maxValue) -> long

- long -> CycleRange(int: maxValue) -> int

- long -> CycleRange(int: minValue, int: maxValue) -> int

- int -> CycleRange(int: maxValue) -> int
  - *notes:* Sets the maximum value of the cycle range. The minimum is default to 0.
@param maxValue The maximum value in the cycle to be added.

  - *example:* `CycleRange(34)`
  - *add a rotating value between 0 and 34 to the input*

- int -> CycleRange(int: minValue, int: maxValue) -> int
  - *notes:* Sets the minimum and maximum value of the cycle range.
@param minValue minimum value of the cycle to be added.
@param maxValue maximum value of the cycle to be added.


## DelimFrequencySampler

Takes a CSV with sample data and generates random values based on the relative frequencies of the values in the file. The CSV file must have headers which can be used to find the named columns. I.E. take the following imaginary \`animals.csv\` file: animal,count,country puppy,1,usa puppy,2,colombia puppy,3,senegal kitten,2,colombia \`CSVFrequencySampler('animals.csv', animal)\` will return \`puppy\` or \`kitten\` randomly. \`puppy\` will be 3x more frequent than \`kitten\`. \`CSVFrequencySampler('animals.csv', country)\` will return \`usa\`, \`colombia\`, or \`senegal\` randomly. \`colombia\` will be 2x more frequent than \`usa\` or \`senegal\`. Use this function to infer frequencies of categorical values from CSVs.

- long -> DelimFrequencySampler(String: filename, String: columnName, char: delimiter) -> String
  - *notes:* Create a sampler of strings from the given delimited file. The delimited file must have plain headers
as its first line.
@param filename The name of the file to be read into the sampler buffer
@param columnName The name of the column to be sampled
@param delimiter delimmiter

  - *example:* `DelimFrequencySampler('values.csv','modelno', '|')`
  - *Read values.csv, count the frequency of values in 'modelno' column, and sample from this column proportionally*

## DirectoryLines

Read each line in each matching file in a directory structure, providing one line for each time this function is called. The files are sorted at the time the function is initialized, and each line is read in order. This function does not produce the same result per cycle value. It is possible that different cycle inputs will return different inputs if the cycles are not applied in strict order. Still, this function is useful for consuming input from a set of files as input to a test or simulation.

- long -> DirectoryLines(String: basepath, String: namePattern) -> String
  - *example:* `DirectoryLines('/var/tmp/bardata', '.*')`
  - *load every line from every file in /var/tmp/bardata*

## Discard

This function takes a long input and ignores it. It returns a generic object which is meant to be used as input to other function which don't need a specific input.

- long -> Discard() -> Object

## Div

Divide the operand by a fixed value and return the result.

- double -> Div(double: divisor) -> double

- long -> Div(int: divisor) -> int

- long -> Div(long: divisor) -> long
  - *example:* `Div(42L)`
  - *divide all inputs by 42L*

- int -> Div(int: divisor) -> int

## DivideToLongToString

This is equivalent to `Div(...)`, but returns the result after String.valueOf(...). This function is also deprecated, as it is easily replaced by other functions.

- long -> DivideToLongToString(long: divisor) -> String

## ElapsedNanoTime

Provide the elapsed nano time since the process started. CAUTION: This does not produce deterministic test data.

- long -> ElapsedNanoTime() -> long

## EscapeJSON

Escape all special characters which are required to be escaped when found within JSON content according to the JSON spec

```
{@code
\b  Backspace (ascii code 08)
\f  Form feed (ascii code 0C)
\n  New line
\r  Carriage return
\t  Tab
\"  Double quote
\\  Backslash character
\/  Forward slash
}
```


- String -> EscapeJSON() -> String

## FieldExtractor

Extracts out a set of fields from a delimited string, returning a string with the same delimiter containing only the specified fields.

- String -> FieldExtractor(String: fields) -> String
  - *example:* `FieldExtractor('|,2,16')`
  - *extract fields 2 and 16 from the input data with '|' as the delimiter*

## FirstLines


- Object -> FirstLines(String: filePath) -> String

- Object -> FirstLines(String: filePath, Integer: numberOfLines) -> String

## FixedValue

Yield a fixed value.

- long -> FixedValue(String: value) -> String

- long -> FixedValue(int: value) -> int
  - *example:* `FixedValue(42)`
  - *always return 42*

- long -> FixedValue(long: fixedValue) -> long

## FixedValues

Yield one of the specified values, rotating through them as the input value increases.

- long -> FixedValues(int[]...: values) -> int

- long -> FixedValues(long[]...: values) -> double
  - *example:* `FixedValues(3D,53D,73d)`
  - *Yield 3D, 53D, 73D, 3D, 53D, 73D, 3D, ...*

- long -> FixedValues(long[]...: values) -> long
  - *example:* `FixedValues(3L,53L,73L)`
  - *Yield 3L, 53L, 73L, 3L, 53L, 73L, 3L, ...*

## FullHash

This uses the Murmur3F (64-bit optimized) version of Murmur3, not as a checksum, but as a simple hash. It doesn't bother pushing the high-64 bits of input, since it only uses the lower 64 bits of output. This version returns the value regardless of this sign bit. It does not return the absolute value, as {@link Hash} does.

- long -> FullHash() -> long

## Hash

This uses the Murmur3F (64-bit optimized) version of Murmur3, not as a checksum, but as a simple hash. It doesn't bother pushing the high-64 bits of input, since it only uses the lower 64 bits of output. It does, however, return the absolute value. This is to make it play nice with users and other libraries.

- long -> Hash() -> long

- int -> Hash() -> int

- long -> Hash() -> int

## HashInterval

Return a value within a range, pseudo-randomly, using interval semantics, where the range of values return does not include the last value. This function behaves exactly like HashRange except for the exclusion of the last value. This allows you to stack intervals using known reference points without duplicating or skipping any given value. You can specify hash intervals as small as a single-element range, like (5,6), or as wide as the relevant data type allows.

- int -> HashInterval(int: width) -> int
  - *notes:* Create a hash interval based on a minimum value of 0 and a specified width.
@param width The maximum value, which is excluded.

  - *example:* `HashInterval(4)`
  - *return values which could include 0, 1, 2, 3, but not 4*

- int -> HashInterval(int: minIncl, int: maxExcl) -> int
  - *notes:* Create a hash interval
@param minIncl The minimum value, which is included
@param maxExcl The maximum value, which is excluded

  - *example:* `HashInterval(2,5)`
  - *return values which could include 2, 3, 4, but not 5*

- long -> HashInterval(int: width) -> int
  - *notes:* Create a hash interval based on a minimum value of 0 and a specified width.
@param width The maximum value, which is excluded.

  - *example:* `HashInterval(4)`
  - *return values which could include 0, 1, 2, 3, but not 4*

- long -> HashInterval(int: minIncl, int: maxExcl) -> int
  - *notes:* Create a hash interval
@param minIncl The minimum value, which is included
@param maxExcl The maximum value, which is excluded

  - *example:* `HashInterval(2,5)`
  - *return values which could include 2, 3, 4, but not 5*

- long -> HashInterval(long: width) -> long
  - *notes:* Create a hash interval based on a minimum value of 0 and a specified width.
@param width The maximum value, which is excluded.

  - *example:* `HashInterval(4L)`
  - *return values which could include 0L, 1L, 2L, 3L, but not 4L*

- long -> HashInterval(long: minIncl, long: maxExcl) -> long
  - *notes:* Create a hash interval
@param minIncl The minimum value, which is included
@param maxExcl The maximum value, which is excluded

  - *example:* `HashInterval(2L,5L)`
  - *return values which could include 2L, 3L, 4L, but not 5L*

## HashRange

Return a value within a range, pseudo-randomly. This is equivalent to returning a value with in range between 0 and some maximum value, but with a minimum value added. You can specify hash ranges as small as a single-element range, like (5,5), or as wide as the relevant data type allows.

- int -> HashRange(int: width) -> int

- int -> HashRange(int: minValue, int: maxValue) -> int

- long -> HashRange(long: width) -> long

- long -> HashRange(long: minValue, long: maxValue) -> long

- long -> HashRange(int: width) -> int
  - *example:* `HashRange(32L)`
  - *map the input to a number in the range 0-31, inclusive, of type int*

- long -> HashRange(int: minValue, int: maxValue) -> int
  - *example:* `HashRange(35L,39L)`
  - *map the input to a number in the range 35-38, inclusive, of type int*

## HashRangeScaled

Return a pseudo-random value which can only be as large as the input times a scale factor, with a default scale factor of 1.0d

- int -> HashRangeScaled(double: scalefactor) -> int

- int -> HashRangeScaled() -> int

- long -> HashRangeScaled(double: scalefactor) -> long

- long -> HashRangeScaled() -> long

- long -> HashRangeScaled(double: scalefactor) -> int

- long -> HashRangeScaled() -> int

## HashedByteBufferExtract

Create a ByteBuffer from the first function, and then sample data from that bytebuffer according to the size function. The initFunction can be given as simply a size, in which case ByteBufferSizedHash is used. If the size function yields a size larger than the available buffer size, then it is lowered to that size automatically. If it is lower, then a random offset is used within the buffer image. This function behaves slightly differently than most in that it creates and caches as source byte buffer during initialization.

- long -> HashedByteBufferExtract(Object: initFunc, Object: sizeFunc) -> java.nio.ByteBuffer

## HashedDoubleRange

Return a double value within the specified range. This function uses an intermediate long to arrive at the sampled value before conversion to double, thus providing a more linear sample at the expense of some precision at extremely large values.

- long -> HashedDoubleRange(double: min, double: max) -> double

## HashedFileExtractToString

Pseudo-randomly extract a section of a text file and return it according to some minimum and maximum extract size. The file is loaded into memory as a shared text image. It is then indexed into as a character buffer to find a pseudo-randomly sized fragment.

- long -> HashedFileExtractToString(String: filename, int: minsize, int: maxsize) -> String
  - *example:* `HashedFileExtractToString('data/adventures.txt',100,200)`
  - *return a fragment from adventures.txt between 100 and 200 characters long*

- long -> HashedFileExtractToString(String: filename, Object: sizefunc) -> String
  - *notes:* Provide a size function for the fragment to be extracted. In this form, if the size function specifies a string
size which is larger than the text image, it is truncated via modulo to fall within the text image size.

@param filename The file name to be loaded
@param sizefunc A function which determines the size of the data to be loaded.

  - *example:* `HashedFileExtractToString('data/adventures.txt',Uniform())`
  - *return a fragment from adventures.txt from a random offset, based on the size function provided.*

## HashedLineToInt

Return a pseudo-randomly selected integer value from a file of numeric values. Each line in the file must contain one parsable integer value.

- long -> HashedLineToInt(String: filename) -> int

## HashedLineToString

Return a pseudo-randomly selected String value from a single line of the specified file.

- long -> HashedLineToString(String: filename) -> String

## HashedLinesToKeyValueString

Generate a string in the format key1:value1;key2:value2;... from the words in the specified file, ranging in size between zero and the specified maximum.

- long -> HashedLinesToKeyValueString(String: paramFile, int: maxsize) -> String

## HashedLoremExtractToString

Provide a text extract from the full lorem ipsum text, between the specified minimum and maximum size.

- long -> HashedLoremExtractToString(int: minsize, int: maxsize) -> String

## HashedRangedToNonuniformDouble

This provides a random sample of a double in a range, without accounting for the non-uniform distribution of IEEE double representation. This means that values closer to high-precision areas of the IEEE spec will be weighted higher in the output. However, NaN and positive and negative infinity are filtered out via oversampling. Results are still stable for a given input value.

- long -> HashedRangedToNonuniformDouble(long: min, long: max) -> double

## HashedToByteBuffer

Hash a long input value into a byte buffer, at least length bytes long, but aligned on 8-byte boundary;

- long -> HashedToByteBuffer(int: lengthInBytes) -> java.nio.ByteBuffer

## Identity

Simply returns the input value. This function intentionally does nothing.

- long -> Identity() -> long

## Interpolate

Return a value along an interpolation curve. This allows you to sketch a basic density curve and describe it simply with just a few values. The number of values provided determines the resolution of the internal lookup table that is used for interpolation. The first value is always the 0.0 anchoring point on the unit interval. The last value is always the 1.0 anchoring point on the unit interval. This means that in order to subdivide the density curve in an interesting way, you need to provide a few more values in between them. Providing two values simply provides a uniform sample between a minimum and maximum value. The input range of this function is, as many of the other functions in this library, based on the valid range of positive long values, between 0L and Long.MAX_VALUE inclusive. This means that if you want to combine interpolation on this curve with the effect of pseudo-random sampling, you need to put a hash function ahead of it in the flow. Developer Note: This is the canonical implementation of LERPing in NoSQLBench, so is heavily documented. Any other LERP implementations should borrow directly from this, embedding by default.

- long -> Interpolate(double[]...: values) -> double
  - *example:* `Interpolate(0.0d,100.0d)`
  - *return a uniform double value between 0.0d and 100.0d*
  - *example:* `Interpolate(0.0d,90.0d,95.0d,98.0d,100.0d)`
  - *return a weighted double value where the first second and third quartiles are 90.0D, 95.0D, and 98.0D*

- long -> Interpolate(double[]...: values) -> long
  - *example:* `Interpolate(0.0d,100.0d)`
  - *return a uniform long value between 0L and 100L*
  - *example:* `Interpolate(0.0d,90.0d,95.0d,98.0d,100.0d)`
  - *return a weighted long value where the first second and third quartiles are 90.0D, 95.0D, and 98.0D*

## Join

This takes any collection and concatenates the String representation with a specified delimiter.

- Collection<T> -> Join(String: delim) -> String
  - *example:* `Join(',')`
  - *Concatenate the incoming collection with ','*

## JoinTemplate

Combine the result of the specified functions together with the specified delimiter and optional prefix and suffix.

- long -> JoinTemplate(String: delimiter, function.LongFunction<?>[]...: funcs) -> String
  - *example:* `JoinTemplate('--',NumberNameToString(),NumberNameToString())`
  - *create values like `one--one`, `two-two`, ...*

- long -> JoinTemplate(String: prefix, String: delimiter, String: suffix, function.LongFunction<?>[]...: funcs) -> String
  - *example:* `JoinTemplate('{',',','}',NumberNameToString(),LastNames())`
  - *create values like '{one,Farrel}', '{two,Haskell}', ...*

- long -> JoinTemplate(function.LongUnaryOperator: iterop, String: prefix, String: delimiter, String: suffix, function.LongFunction<?>[]...: funcs) -> String
  - *example:* `JoinTemplate(Add(3),'<',';','>',NumberNameToString(),NumberNameToString(),NumberNameToString())`
  - *create values like '<zero;three,six>', '<one;four,seven>', ...*

## ListTemplate

Create a {@code List} based on two functions, the first to determine the list size, and the second to populate the list with string values. The input fed to the second function is incremented between elements.

- long -> ListTemplate(function.LongToIntFunction: sizeFunc, function.LongFunction<String>: valueFunc) -> List<String>
  - *example:* `ListTemplate(HashRange(3,7),NumberNameToString())`
  - *create a list between 3 and 7 elements, with number names as the values*

## LoadElement

Load a value from a map, based on the injected configuration. The map which is used must be named by the mapname. If the injected configuration contains a variable of this name which is also a Map, then this map is referenced and read by the provided variable name.

- Object -> LoadElement(String: varname, String: mapname, Object: defaultValue) -> Object
  - *example:* `LoadElement('varname','vars','defaultvalue')`
  - *Load the varable 'varname' from a map named 'vars', or provide 'defaultvalue' if neither is provided*

## LongToString

Return the string representation of the provided long. @deprecated use ToString() instead

- long -> LongToString() -> String

## MatchFunc

Match any input with a regular expression, and apply the associated function to it, yielding the value. If no matches occur, then the original value is passed through unchanged. Patterns and functions are passed as even,odd pairs indexed from the 0th position. Instead of a function, a String value may be provided as the associated output value.

- String -> MatchFunc(Object[]...: funcs) -> String
  - *example:* `MatchFunc('.*','onevalue')`
  - *Match all String inputs, simply returning 'onevalue' as the output value.*
  - *example:* `MatchFunc('[0-9]+',Suffix('-is-a-number'))`
  - *Append '-is-a-number' to every input which is a sequence of digits*

## MatchRegex

Match any input with a regular expression, and apply the associated regex replacement to it, yielding the value. If no matches occur, then the original value is passed through unchanged. Patterns and replacements are passed as even,odd pairs indexed from the 0th position. Back-references to matching groups are supported.

- String -> MatchRegex(String[]...: specs) -> String
  - *example:* `MatchRegex('.*(25|6to4).*','$1')`
  - *Match 25 or 6 to 4 and set the output to only that*
  - *example:* `MatchRegex('([0-9]+)-([0-9]+)-([0-9]+)','$1 $2 $3'`
  - *replaced dashes with spaces in a 10 digit US phone number.*

## Max

Return the maximum of either the input value or the specified max.

- double -> Max(double: max) -> double

- long -> Max(long: max) -> long
  - *example:* `Max(42L)`
  - *take the value of 42L or the input, which ever is greater*
  - *example:* `Max(-42L)`
  - *take the value of -42L or the input, which ever is greater*

- int -> Max(int: max) -> int

## Min

Return the minimum of either the input value or the specified minimum.

- double -> Min(double: min) -> double

- long -> Min(long: min) -> long

- int -> Min(int: min) -> int

## Mod

Return the result of modulo division by the specified divisor.

- long -> Mod(long: modulo) -> long

- int -> Mod(int: modulo) -> int

- long -> Mod(int: modulo) -> int

## ModuloCSVLineToString

Select a value from a CSV file line by modulo division against the number of lines in the file. The second parameter is the field name, and this must be provided in the CSV header line as written.

- long -> ModuloCSVLineToString(String: filename, String: fieldname) -> String
  - *example:* `ModuloCSVLineToString('data/myfile.csv','lat')`
  - *load values for 'lat' from the CSV file myfile.csv.*

## ModuloLineToString

Select a value from a text file line by modulo division against the number of lines in the file.

- long -> ModuloLineToString(String: filename) -> String

## ModuloToInteger

Return an integer value as the result of modulo division with the specified divisor.

- long -> ModuloToInteger(int: modulo) -> Integer

## ModuloToLong

Return a long value as the result of modulo division with the specified divisor.

- long -> ModuloToLong(long: modulo) -> long

## Mul

Return the result of multiplying the specified value with the input.

- double -> Mul(double: factor) -> double

- long -> Mul(long: multiplicand) -> long

- int -> Mul(int: addend) -> int

- long -> Mul(int: multiplicand) -> int

## Murmur3DivToLong

Yield a long value which is the result of hashing and modulo division with the specified divisor.

- long -> Murmur3DivToLong(long: divisor) -> long

## Murmur3DivToString

Yield a String value which is the result of hashing and modulo division with the specified divisor to long and then converting the value to String.

- long -> Murmur3DivToString(long: divisor) -> String

## NumberNameToString

Provides the spelled-out name of a number. For example, an input of 7 would yield "seven". An input of 4234 yields the value "four thousand thirty four". The maximum value is limited at 999,999,999.

- long -> NumberNameToString() -> String

## PartitionLongs

Split the value range of Java longs into a number of offsets, starting with Long.MIN_VALUE. This method makes it easy to construct a set of offsets for testing, or to limit the values used a subset. The outputs will range from Long.MIN_VALUE (-2\^63) up. This is not an exactly emulation of token range splits in Apache Cassandra.

- long -> PartitionLongs(int: partitions) -> long

## Prefix

Add the specified prefix String to the input value and return the result.

- String -> Prefix(String: prefix) -> String
  - *example:* `Prefix('PREFIX:')`
  - *Prepend 'PREFIX:' to every input value*

## ReplaceAll

Replace all occurrences of the extant string with the replacement string.

- String -> ReplaceAll(String: extant, String: replacement) -> String
  - *example:* `ReplaceAll('one','two')`
  - *Replace all occurrences of 'one' with 'two'*

## ReplaceRegex

Replace all occurrences of the regular expression with the replacement string. Note, this is much less efficient than using the simple ReplaceAll for most cases.

- String -> ReplaceRegex(String: regex, String: replacement) -> String
  - *example:* `ReplaceRegex('[one]','two')`
  - *Replace all occurrences of 'o' or 'n' or 'e' with 'two'*

## Shuffle

This function provides a low-overhead shuffling effect without loading elements into memory. It uses a bundled dataset of pre-computed Galois LFSR shift register configurations, along with a down-sampling method to provide amortized virtual shuffling with minimal memory usage. Essentially, this guarantees that every value in the specified range will be seen at least once before the cycle repeats. However, since the order of traversal of these values is dependent on the LFSR configuration, some orders will appear much more random than others depending on where you are in the traversal cycle. This function \*does\* yield values that are deterministic.

- long -> Shuffle(long: min, long: maxPlusOne) -> long
  - *example:* `Shuffle(11,99)`
  - *Provide all values between 11 and 98 inclusive, in some order, then repeat*

- long -> Shuffle(long: min, long: maxPlusOne, int: bankSelector) -> long
  - *example:* `Shuffle(11,99,3)`
  - *Provide all values between 11 and 98 inclusive, in some different (and repeatable) order, then repeat*

## SignedHash

This uses the Murmur3F (64-bit optimized) version of Murmur3, not as a checksum, but as a simple hash. It doesn't bother pushing the high-64 bits of input, since it only uses the lower 64 bits of output. Unlike the other hash functions, this one may return positive as well as negative values.

- long -> SignedHash() -> long

- int -> SignedHash() -> int

- long -> SignedHash() -> int

## StaticStringMapper

Return a static String value.

- long -> StaticStringMapper(String: string) -> String

## Suffix

Add the specified prefix String to the input value and return the result.

- String -> Suffix(String: suffix) -> String
  - *example:* `Suffix('--Fin')`
  - *Append '--Fin' to every input value*

## Template

Creates a template function which will yield a string which fits the template provided, with all occurrences of `{}` substituted pair-wise with the result of the provided functions. The number of `{}` entries in the template must strictly match the number of functions or an error will be thrown. If you need to include single quotes or other special characters, you may use a backslash "\\" in your template. The objects passed must be functions of any of the following types:

* LongUnaryOperator
* IntUnaryOperator
* DoubleUnaryOperator
* LongFunction
* IntFunction
* DoubleFunction
* Function\<Long,?\>

The result of applying the input value to any of these functions is converted to a String
and then stitched together according to the template provided.

- long -> Template(String: template, Object[]...: funcs) -> String
  - *example:* `Template('{}-{}',Add(10),Hash())`
  - *concatenate input+10, '-', and a pseudo-random long*

- long -> Template(boolean: truncate, String: template, Object[]...: funcs) -> String
  - *example:* `Template(true, '{}-{}', Add(10),Hash())`
  - *throws an error, as the Add(10) function causes a narrowing conversion for a long input*

- long -> Template(function.LongUnaryOperator: iterOp, String: template, function.LongFunction<?>[]...: funcs) -> String
  - *notes:* If an operator is provided, it is used to change the function input value in an additional way before each function.

@param iterOp   A pre-generation value mapping function
@param template A string template containing <pre>{}</pre> anchors
@param funcs    A varargs length of LongFunctions of any output type


## ThreadNumToInteger

Matches a digit sequence in the current thread name and caches it in a thread local. This allows you to use any intentionally indexed thread factories to provide an analogue for concurrency. Note that once the thread number is cached, it will not be refreshed. This means you can't change the thread name and get an updated value.

- long -> ThreadNumToInteger() -> Integer

## ThreadNumToLong

Matches a digit sequence in the current thread name and caches it in a thread local. This allows you to use any intentionally indexed thread factories to provide an analogue for concurrency. Note that once the thread number is cached, it will not be refreshed. This means you can't change the thread name and get an updated value.

- long -> ThreadNumToLong() -> long

## ToBase64

Takes a bytebuffer and turns it into a base64 string

- java.nio.ByteBuffer -> ToBase64() -> String

## ToHashedUUID

This function provides a stable hashing of the input value to a version 4 (Random) UUID.

- long -> ToHashedUUID() -> UUID

## Trim

Trim the input value and return the result.

- String -> Trim() -> String

## WeightedLongs

Provides a long value from a list of weighted values. The total likelihood of any value to be produced is proportional to its relative weight in the total weight of all elements. This function automatically hashes the input, so the result is already pseudo-random.

- long -> WeightedLongs(String: valuesAndWeights) -> Long
  - *example:* `WeightedLongs('1:10;3;5;12345;1`
  - *Yield 1 62.5% of the time, 3 31.25% of the time, and 12345 6.2% of the time*
  - *example:* `WeightedLongs('1,6,7`
  - *Yield 1 33.3% of the time, 6 33.3% of the time, and 7 33.3% of the time*

## WeightedStrings

Allows for weighted elements to be used, such as `a:0.25;b:0.25;c:0.5` or `a:1;b:1.0;c:2.0` The unit weights are normalized to the cumulative sum internally, so it is not necessary for them to add up to any particular value.

- long -> WeightedStrings(String: valuesAndWeights) -> String

## WeightedStringsFromCSV

Provides sampling of a given field in a CSV file according to discrete probabilities. The CSV file must have headers which can be used to find the named columns for value and weight. The value column contains the string result to be returned by the function. The weight column contains the floating-point weight or mass associated with the value on the same line. All the weights are normalized automatically.

If there are multiple file names containing the same format, then they
will all be read in the same way.

If the first word in the filenames list is 'map', then the values will not
be pseudo-randomly selected. Instead, they will be mapped over in some
other unsorted and stable order as input values vary from 0L to Long.MAX_VALUE.

Generally, you want to leave out the 'map' directive to get "random sampling"
of these values.

This function works the same as the three-parametered form of WeightedStrings,
which is deprecated in lieu of this one. Use this one instead.

- long -> WeightedStringsFromCSV(String: valueColumn, String: weightColumn, String[]...: filenames) -> String
  - *notes:* Create a sampler of strings from the given CSV file. The CSV file must have plain CSV headers
as its first line.
@param valueColumn The name of the value column to be sampled
@param weightColumn The name of the weight column, which must be parsable as a double
@param filenames One or more file names which will be read in to the sampler buffer


