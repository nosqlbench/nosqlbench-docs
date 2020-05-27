---
title: general functions
weight: 20
---

These functions have no particular category, so they ended up here by default.

## ModuloLineToString

Select a value from a text file line by modulo division against the number of lines in the file.

- long -> ModuloLineToString(String: filename) -> String

## AddHashRange

Adds a pseudo-random value within the specified range to the input.

- long -> AddHashRange(long: maxValue) -> long

- long -> AddHashRange(long: minValue, long: maxValue) -> long

- long -> AddHashRange(int: maxValue) -> int

- long -> AddHashRange(int: minValue, int: maxValue) -> int

- int -> AddHashRange(int: maxValue) -> int

- int -> AddHashRange(int: minValue, int: maxValue) -> int

## SnappyComp


- String -> SnappyComp() -> java.nio.ByteBuffer

## Exponential


- long -> Exponential(double: mean, String[]...: mods) -> double

## MatchFunc

Match any input with a regular expression, and apply the associated function to it, yielding the value. If no matches occur, then the original value is passed through unchanged. Patterns and functions are passed as even,odd pairs indexed from the 0th position. Instead of a function, a String value may be provided as the associated output value.

- String -> MatchFunc(Object[]...: funcs) -> String
  - *example:* `MatchFunc('.*','onevalue')`
  - *Match all String inputs, simply returning 'onevalue' as the output value.*
  - *example:* `MatchFunc('[0-9]+',Suffix('-is-a-number'))`
  - *Append '-is-a-number' to every input which is a sequence of digits*

## Hash

This uses the Murmur3F (64-bit optimized) version of Murmur3, not as a checksum, but as a simple hash. It doesn't bother pushing the high-64 bits of input, since it only uses the lower 64 bits of output. It does, however, return the absolute value. This is to make it play nice with users and other libraries. This uses the Murmur3F (64-bit optimized) version of Murmur3, not as a checksum, but as a simple hash. It doesn't bother pushing the high-64 bits of input, since it only uses the lower 64 bits of output. It does, however, return the absolute value. This is to make it play nice with users and other libraries. This uses the Murmur3F (64-bit optimized) version of Murmur3, not as a checksum, but as a simple hash. It doesn't bother pushing the high-64 bits of input, since it only uses the lower 64 bits of output. It does, however, return the absolute value. This is to make it play nice with users and other libraries.

- long -> Hash() -> long

- int -> Hash() -> int

- long -> Hash() -> int

## SignedHash

This uses the Murmur3F (64-bit optimized) version of Murmur3, not as a checksum, but as a simple hash. It doesn't bother pushing the high-64 bits of input, since it only uses the lower 64 bits of output. Unlike the other hash functions, this one may return positive as well as negative values.

- long -> SignedHash() -> long

- int -> SignedHash() -> int

- long -> SignedHash() -> int

## Beta


- long -> Beta(double: alpha, double: beta, String[]...: mods) -> double

## TokenMapFileNextToken


- int -> TokenMapFileNextToken(String: filename, boolean: loopdata, boolean: ascending) -> long

## Pascal


- long -> Pascal(int: r, double: p, String[]...: modslist) -> int

- int -> Pascal(int: r, double: p, String[]...: modslist) -> long

- long -> Pascal(int: r, double: p, String[]...: modslist) -> long

## Identity

Simply returns the input value. This function intentionally does nothing.

- long -> Identity() -> long

## HashRangeScaled

Return a pseudo-random value which can only be as large as the input.

- int -> HashRangeScaled() -> int

- long -> HashRangeScaled() -> long

- long -> HashRangeScaled() -> int

## Distance

Create a Distance generator which produces com.datastax.driver.dse.geometry.Distance objects.

- long -> Distance(function.LongToDoubleFunction: xfunc, function.LongToDoubleFunction: yfunc, function.LongToDoubleFunction: rfunc) -> com.datastax.driver.dse.geometry.Distance

- long -> Distance(double: x, function.LongToDoubleFunction: yfunc, function.LongToDoubleFunction: rfunc) -> com.datastax.driver.dse.geometry.Distance

- long -> Distance(function.LongToDoubleFunction: xfunc, double: y, function.LongToDoubleFunction: rfunc) -> com.datastax.driver.dse.geometry.Distance

- long -> Distance(double: x, double: y, function.LongToDoubleFunction: rfunc) -> com.datastax.driver.dse.geometry.Distance

- long -> Distance(function.LongToDoubleFunction: xfunc, function.LongToDoubleFunction: yfunc, double: r) -> com.datastax.driver.dse.geometry.Distance

- long -> Distance(double: x, function.LongToDoubleFunction: yfunc, double: r) -> com.datastax.driver.dse.geometry.Distance

- long -> Distance(function.LongToDoubleFunction: xfunc, double: y, double: r) -> com.datastax.driver.dse.geometry.Distance

- long -> Distance(double: x, double: y, double: r) -> com.datastax.driver.dse.geometry.Distance

## NumberNameToString

Provides the spelled-out name of a number. For example, an input of 7 would yield "seven". An input of 4234 yields the value "four thousand thirty four". The maximum value is limited at 999,999,999.

- long -> NumberNameToString() -> String

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

## ThreadNumToInteger

Matches a digit sequence in the current thread name and caches it in a thread local. This allows you to use any intentionally indexed thread factories to provide an analogue for concurrency. Note that once the thread number is cached, it will not be refreshed. This means you can't change the thread name and get an updated value.

- long -> ThreadNumToInteger() -> Integer

## WeightedLongs

Provides a long value from a list of weighted values. The total likelihood of any value to be produced is proportional to its relative weight in the total weight of all elements. This function automatically hashes the input, so the result is already pseudo-random.

- long -> WeightedLongs(String: valuesAndWeights) -> Long
  - *example:* `WeightedLongs('1:10;3;5;12345;1`
  - *Yield 1 62.5% of the time, 3 31.25% of the time, and 12345 6.2% of the time*
  - *example:* `WeightedLongs('1,6,7`
  - *Yield 1 33.3% of the time, 6 33.3% of the time, and 7 33.3% of the time*

## Nakagami


- long -> Nakagami(double: mu, double: omega, String[]...: mods) -> double

## LogNormal


- long -> LogNormal(double: scale, double: shape, String[]...: mods) -> double

## Poisson


- long -> Poisson(double: p, String[]...: modslist) -> long

- int -> Poisson(double: p, String[]...: modslist) -> long

- long -> Poisson(double: p, String[]...: modslist) -> int

## Suffix

Add the specified prefix String to the input value and return the result.

- String -> Suffix(String: suffix) -> String
  - *example:* `Suffix('--Fin')`
  - *Append '--Fin' to every input value*

## Min

Return the minimum of either the input value or the specified minimum.

- double -> Min(double: min) -> double

- long -> Min(long: min) -> long

- int -> Min(int: min) -> int

## CSVFrequencySampler

Takes a CSV with sample data and generates random values based on the relative frequencies of the values in the file. The CSV file must have headers which can be used to find the named columns. I.E. take the following imaginary \`animals.csv\` file: animal,count,country puppy,1,usa puppy,2,colombia puppy,3,senegal kitten,2,colombia \`CSVFrequencySampler('animals.csv', animal)\` will return \`puppy\` or \`kitten\` randomly. \`puppy\` will be 3x more frequent than \`kitten\`. \`CSVFrequencySampler('animals.csv', country)\` will return \`usa\`, \`colombia\`, or \`senegal\` randomly. \`colombia\` will be 2x more frequent than \`usa\` or \`senegal\`. Use this function to infer frequencies of categorical values from CSVs.

- long -> CSVFrequencySampler(String: filename, String: columnName) -> String
  - *notes:* Create a sampler of strings from the given CSV file. The CSV file must have plain CSV headers
as its first line.
@param filename The name of the file to be read into the sampler buffer
@param columnName The name of the column to be sampled

  - *example:* `CSVFrequencySampler('values.csv','modelno')`
  - *Read values.csv, count the frequency of values in 'modelno' column, and sample from this column proportionally*

## ModuloToLong

Return a long value as the result of modulo division with the specified divisor.

- long -> ModuloToLong(long: modulo) -> long

## Expr

Allow for the use of arbitrary expressions according to the [MVEL](http://mvel.documentnode.com/) expression language. Variables that have been set by a Save function are available to be used in this function. The variable name `cycle` is reserved, and is always equal to the current input value. This is not the same in every case as the current cycle of an operation. It could be different if there are preceding functions which modify the input value.

- long -> Expr(String: expr) -> int

- long -> Expr(String: expr) -> long

- long -> Expr(String: expr) -> String

- long -> Expr(String: expr) -> UUID

- int -> Expr(String: expr) -> int

- double -> Expr(String: expr) -> double

## Triangular


- long -> Triangular(double: a, double: c, double: b, String[]...: mods) -> double

## WeightedStrings

Allows for weighted elements to be used, such as `a:0.25;b:0.25;c:0.5` or `a:1;b:1.0;c:2.0` The unit weights are normalized to the cumulative sum internally, so it is not necessary for them to add up to any particular value.

- long -> WeightedStrings(String: valuesAndWeights) -> String

## Levy


- long -> Levy(double: mu, double: c, String[]...: mods) -> double

## PolygonOnGrid

This function will return a polygon in the form of a rectangle from the specified grid system. The coordinates define the top left and bottom right coordinates in (x1,y1),(x2,y2) order, while the number of rows and columns divides these ranges into the unit-length for each square. x1 must be greater than x2. y1 must be less than y2. This grid system can be used to construct a set of overlapping grids such that the likelyhood of overlap is somewhat easy to reason about. For example, if you create one grid system as a refernce grid, then attempt to map another grid system which half overlaps the original grid, you can easily determine that half the time, a random rectangle selected from the second grid will overlap a rectangle from the first, for simple even-numbered grids and the expected uniform sampling on the internal coordinate selector functions.

- long -> PolygonOnGrid(double: x_topleft, double: y_topleft, double: x_bottomright, double: y_bottomright, int: rows, int: columns) -> com.datastax.driver.dse.geometry.Polygon
  - *example:* `PolygonOnGrid(1, 11, 11, 1, 10, 10)`
  - *Create a 10x10 grid with cells 1x1, spaced one off the y=0 and x=0 axes*

## Weibull


- long -> Weibull(double: alpha, double: beta, String[]...: mods) -> double

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


## Max

Return the maximum of either the input value or the specified max.

- double -> Max(double: max) -> double

- long -> Max(long: max) -> long
  - *example:* `Max(42L)`
  - *take the value of 42L or the input, which ever is greater*
  - *example:* `Max(-42L)`
  - *take the value of -42L or the input, which ever is greater*

- int -> Max(int: max) -> int

## F


- long -> F(double: numeratorDegreesOfFreedom, double: denominatorDegreesOfFreedom, String[]...: mods) -> double

## DecimalFormat

Formats a floating point value to a string using the java.text.DecimalFormat

- double -> DecimalFormat(String: format) -> String
  - *example:* `DecimalFormat('.##')`
  - *converts a double value to a string with only two digits after the decimal*

## Geometric


- long -> Geometric(double: p, String[]...: modslist) -> long

- int -> Geometric(double: p, String[]...: modslist) -> long

- long -> Geometric(double: p, String[]...: modslist) -> int

## Prefix

Add the specified prefix String to the input value and return the result.

- String -> Prefix(String: prefix) -> String
  - *example:* `Prefix('PREFIX:')`
  - *Prepend 'PREFIX:' to every input value*

## TokenMapFileToken


- int -> TokenMapFileToken(String: filename, boolean: loopdata, boolean: ascending) -> long

## ToUUID

This function creates a non-random UUID in the type 4 version (Random). It always puts the same value in the MSB position of the UUID format. The input value is put in the LSB position.

```
xxxxxxxx-xxxx-Mxxx-Nxxx-xxxxxxxxxxxx
mmmmmmmm-mmmm-Mmmm-Llll-llllllllllll
              4    3
```

As shown above, the LSB position does not have the complication of having a version identifier (position M) dividing the dynamic range of the data type. For this reason, only the LSB side is used for this mapper, which allows an effective range of Long.MAX_VALUE/8, given the loss of 3 digits of precision. This function is suitable for deterministic testing of scenarios which depend on type 4 UUIDs, but without the mandated randomness that makes testing difficult. Just be aware that the MSB will always contain value 0x0123456789ABCDEFL unless you specify a different long value to pre-fill it with.

- long -> ToUUID() -> UUID

- long -> ToUUID(long: msbs) -> UUID

## Enumerated


- long -> Enumerated(String: data, String[]...: mods) -> double
  - *example:* `Enumerated('1 2 3 4 5 6')`
  - *a fair 6-sided die*
  - *example:* `Enumerated('1:2.0 2 3 4 5:0.5 6:0.5')`
  - *an unfair fair 6-sided die, where ones are twice as likely, and fives and sixes are half as likely*

## TokenMapFileNextCycle


- int -> TokenMapFileNextCycle(String: filename, boolean: loopdata, boolean: ascending) -> long

## WrappedClustering


- int -> WrappedClustering() -> int

## T


- long -> T(double: degreesOfFreedom, String[]...: mods) -> double

## HashedDoubleRange

Return a double value within the specified range. This function uses an intermediate long to arrive at the sampled value before conversion to double, thus providing a more linear sample at the expense of some precision at extremely large values.

- long -> HashedDoubleRange(double: min, double: max) -> double

## FixedValues

Yield one of the specified values, rotating through them as the input value increases.

- long -> FixedValues(int[]...: values) -> int

- long -> FixedValues(long[]...: values) -> long
  - *example:* `FixedValues(3L,53L,73L)`
  - *Yield 3L, 53L, 73L, 3L, 53L, 73L, 3L, ...*

## DoubleToFloat

Convert the input double value to the closest float value.

- double -> DoubleToFloat() -> Float

## Shuffle

This function provides a low-overhead shuffling effect without loading elements into memory. It uses a bundled dataset of pre-computed Galois LFSR shift register configurations, along with a down-sampling method to provide amortized virtual shuffling with minimal memory usage. Essentially, this guarantees that every value in the specified range will be seen at least once before the cycle repeats. However, since the order of traversal of these values is dependent on the LFSR configuration, some orders will appear much more random than others depending on where you are in the traversal cycle. This function \*does\* yield values that are deterministic.

- long -> Shuffle(long: min, long: maxPlusOne) -> long
  - *example:* `Shuffle(11,99)`
  - *Provide all values between 11 and 98 inclusive, in some order, then repeat*

- long -> Shuffle(long: min, long: maxPlusOne, int: bankSelector) -> long
  - *example:* `Shuffle(11,99,3)`
  - *Provide all values between 11 and 98 inclusive, in some different (and repeatable) order, then repeat*

## HashedLineToInt

Return a pseudo-randomly selected integer value from a file of numeric values. Each line in the file must contain one parsable integer value.

- long -> HashedLineToInt(String: filename) -> int

## Trim

Trim the input value and return the result.

- String -> Trim() -> String

## CustomFunc955

Temporary function to test a specific nested type. This should be replaced with a general custom/tuple type aware binding function. The type supported is a CQL type: {@code map\>} Functions are required for:
* 
* map size {@code (LongToIntFunction)}
* key {@code (LongFunction)}
  * tuple field 1 {@code (LongToIntFunction)}
  * tuple field 2 {@code {LongToIntFunction)}


- long -> CustomFunc955(function.LongToIntFunction: sizefunc, function.LongFunction<Object>: keyfunc, function.LongToIntFunction: field1func, function.LongToIntFunction: field2func) -> Map<?,?>

- long -> CustomFunc955(function.LongToIntFunction: sizefunc, function.LongFunction<Object>: keyfunc, function.LongToIntFunction: field1func, function.LongUnaryOperator: field2func) -> Map<?,?>

## ConstantContinuous


- long -> ConstantContinuous(double: value, String[]...: mods) -> double

## FixedValue

Yield a fixed value.

- long -> FixedValue(String: value) -> String

- long -> FixedValue(int: value) -> int
  - *example:* `FixedValue(42)`
  - *always return 42*

- long -> FixedValue(long: fixedValue) -> long

## EpochMillisToJavaLocalDateTime

Converts epoch millis to a java.time.{@link LocalDateTime} object, using either the system default timezone or the timezone provided. If the specified ZoneId is not the same as the time base of the epoch millis instant, then conversion errors will occur. Short form ZoneId values like 'CST' can be used, although US Domestic names which specify the daylight savings hours are not supported. The full list of short Ids at @see [JavaSE ZoneId Ids](https://docs.oracle.com/en/java/javase/12/docs/api/java.base/java/time/ZoneId.html#SHORT_IDS) Any timezone specifier may be used which can be read by {@link ZoneId#of(String)}

- long -> EpochMillisToJavaLocalDateTime() -> java.time.LocalDateTime
  - *example:* `EpochMillisToJavaLocalDateTime()`
  - *Yields the LocalDateTime for the system default ZoneId*

- long -> EpochMillisToJavaLocalDateTime(String: zoneid) -> java.time.LocalDateTime
  - *example:* `EpochMillisToJavaLocalDateTime('ECT')`
  - *Yields the LocalDateTime for the ZoneId entry for 'Europe/Paris'*

## Normal


- long -> Normal(double: mean, double: sd, String[]...: mods) -> double

## TokenMapFileCycle


- int -> TokenMapFileCycle(String: filename, boolean: loopdata, boolean: ascending) -> long

## FieldExtractor

Extracts out a set of fields from a delimited string, returning a string with the same delimiter containing only the specified fields.

- String -> FieldExtractor(String: fields) -> String
  - *example:* `FieldExtractor('|,2,16')`
  - *extract fields 2 and 16 from the input data with '|' as the delimiter*

## Pareto


- long -> Pareto(double: scale, double: shape, String[]...: mods) -> double

## Div

Divide the operand by a fixed value and return the result.

- double -> Div(double: divisor) -> double

- long -> Div(int: divisor) -> int

- long -> Div(long: divisor) -> long
  - *example:* `Div(42L)`
  - *divide all inputs by 42L*

- int -> Div(int: divisor) -> int

## Interpolate

Return a value along an interpolation curve. This allows you to sketch a basic density curve and describe it simply with just a few values. The number of values provided determines the resolution of the internal lookup table that is used for interpolation. The first value is always the 0.0 anchoring point on the unit interval. The last value is always the 1.0 anchoring point on the unit interval. This means that in order to subdivide the density curve in an interesting way, you need to provide a few more values in between them. Providing two values simply provides a uniform sample between a minimum and maximum value. The input range of this function is, as many of the other functions in this library, based on the valid range of positive long values, between 0L and Long.MAX_VALUE inclusive. This means that if you want to combine interpolation on this curve with the effect of pseudo-random sampling, you need to put a hash function ahead of it in the flow.

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

## ModuloCSVLineToUUID

Select a value from a CSV file line by modulo division against the number of lines in the file. The second parameter is the field name, and this must be provided in the CSV header line as written.

- long -> ModuloCSVLineToUUID(String: filename, String: fieldname) -> UUID
  - *example:* `ModuloCSVLineToUUID('data/myfile.csv','lat')`
  - *load values for 'lat' from the CSV file myfile.csv.*

## EpochMillisToCqlLocalDate

Converts epoch millis to a com.datastax.driver.core.{@link LocalDate} object, as the number of milliseconds since January 1st, 1970 GMT.

- long -> EpochMillisToCqlLocalDate() -> com.datastax.driver.core.LocalDate
  - *example:* `EpochMillisToJavaLocalDate()`
  - *Yields the LocalDate for the millis in GMT*

## HashedLinesToKeyValueString

Generate a string in the format key1:value1;key2:value2;... from the words in the specified file, ranging in size between zero and the specified maximum.

- long -> HashedLinesToKeyValueString(String: paramFile, int: maxsize) -> String

## FullHash

This uses the Murmur3F (64-bit optimized) version of Murmur3, not as a checksum, but as a simple hash. It doesn't bother pushing the high-64 bits of input, since it only uses the lower 64 bits of output. This version returns the value regardless of this sign bit. It does not return the absolute value, as {@link Hash} does.

- long -> FullHash() -> long

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

## ToString

Converts the input to the most obvious string representation with String.valueOf(...). Forms which accept a function will evaluate that function first and then apply String.valueOf() to the result.

- Object -> ToString() -> String

## Cauchy


- long -> Cauchy(double: median, double: scale, String[]...: mods) -> double

## Add

Adds a value to the input.

- double -> Add(double: addend) -> double

- long -> Add(int: addend) -> int

- long -> Add(long: addend) -> long

- int -> Add(int: addend) -> int
  - *example:* `Add(23)`
  - *adds integer 23 to the input integer value*

## ModuloCSVLineToString

Select a value from a CSV file line by modulo division against the number of lines in the file. The second parameter is the field name, and this must be provided in the CSV header line as written.

- long -> ModuloCSVLineToString(String: filename, String: fieldname) -> String
  - *example:* `ModuloCSVLineToString('data/myfile.csv','lat')`
  - *load values for 'lat' from the CSV file myfile.csv.*

## HashRange

Return a value within a range, pseudo-randomly. This is equivalent to returning a value with in range between 0 and some maximum value, but with a minimum value added.

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

## AddCycleRange

Adds a cycle range to the input, producing an increasing sawtooth-like output.

- long -> AddCycleRange(int: maxValue) -> int

- long -> AddCycleRange(int: minValue, int: maxValue) -> int

- long -> AddCycleRange(long: maxValue) -> long

- long -> AddCycleRange(long: minValue, long: maxValue) -> long

- int -> AddCycleRange(int: maxValue) -> int

- int -> AddCycleRange(int: minValue, int: maxValue) -> int

## Uniform


- long -> Uniform(int: lower, int: upper, String[]...: modslist) -> int

- int -> Uniform(int: lower, int: upper, String[]...: modslist) -> long

- long -> Uniform(int: lower, int: upper, String[]...: modslist) -> long

- long -> Uniform(double: lower, double: upper, String[]...: mods) -> double

## StaticStringMapper

Return a static String value.

- long -> StaticStringMapper(String: string) -> String

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


## Gamma


- long -> Gamma(double: shape, double: scale, String[]...: mods) -> double

## Murmur3DivToString

Yield a String value which is the result of hashing and modulo division with the specified divisor to long and then converting the value to String.

- long -> Murmur3DivToString(long: divisor) -> String

## Swap


- long -> Swap(String: name) -> long
  - *example:* `Swap('foo')`
  - *for the current thread, swap the input value with the named variable and returned the named variable.*

- long -> Swap(String: name, long: defaultValue) -> long
  - *example:* `Swap('foo',234L)`
  - *for the current thread, swap the input value with the named variable and returned the named variable,or the default value if the named variable is not defined.*

- long -> Swap(function.LongFunction<String>: nameFunc) -> long
  - *example:* `Swap(NumberNameToString())`
  - *for the current thread, swap the input value with the named variable and returned the named variable, where the variable name is generated by the provided function.*

- long -> Swap(function.LongFunction<String>: nameFunc, long: defaultValue) -> long
  - *example:* `Swap(NumberNameToString(), 234L)`
  - *for the current thread, swap the input value with the named variable and returned the named variable, where the variable name is generated by the provided function, or the default value if the named variable is not defined.*

## Hypergeometric


- int -> Hypergeometric(int: populationSize, int: numberOfSuccesses, int: sampleSize, String[]...: modslist) -> long

- long -> Hypergeometric(int: populationSize, int: numberOfSuccesses, int: sampleSize, String[]...: modslist) -> long

- long -> Hypergeometric(int: populationSize, int: numberOfSuccesses, int: sampleSize, String[]...: modslist) -> int

## Polygon


- long -> Polygon(function.LongToIntFunction: lenfunc, function.LongFunction<com.datastax.driver.dse.geometry.Point>: pointfunc) -> com.datastax.driver.dse.geometry.Polygon

- long -> Polygon(function.LongToIntFunction: lenfunc, function.LongToDoubleFunction: xfunc, function.LongToDoubleFunction: yfunc) -> com.datastax.driver.dse.geometry.Polygon

- long -> Polygon(int: len, function.LongFunction<com.datastax.driver.dse.geometry.Point>: pointfunc) -> com.datastax.driver.dse.geometry.Polygon

## AlphaNumericString

Create an alpha-numeric string of the specified length, character-by-character.

- long -> AlphaNumericString(int: length) -> String

## HashedLoremExtractToString

Provide a text extract from the full lorem ipsum text, between the specified minimum and maximum size.

- long -> HashedLoremExtractToString(int: minsize, int: maxsize) -> String

## Mul

Return the result of multiplying the specified value with the input.

- double -> Mul(double: factor) -> double

- long -> Mul(long: multiplicand) -> long

- int -> Mul(int: addend) -> int

- long -> Mul(int: multiplicand) -> int

## HashedToByteBuffer

Hash a long input value into a byte buffer, at least length bytes long, but aligned on 8-byte boundary;

- long -> HashedToByteBuffer(int: lengthInBytes) -> java.nio.ByteBuffer

## ThreadNum

Matches a digit sequence in the current thread name and caches it in a thread local. This allows you to use any intentionally indexed thread factories to provide an analogue for concurrency. Note that once the thread number is cached, it will not be refreshed. This means you can't change the thread name and get an updated value. Matches a digit sequence in the current thread name and caches it in a thread local. This allows you to use any intentionally indexed thread factories to provide an analogue for concurrency. Note that once the thread number is cached, it will not be refreshed. This means you can't change the thread name and get an updated value.

- long -> ThreadNum() -> int

- long -> ThreadNum() -> long

## LoadElement

Load a value from a map, based on the injected configuration. The map which is used must be named by the mapname. If the injected configuration contains a variable of this name which is also a Map, then this map is referenced and read by the provided variable name.

- Object -> LoadElement(String: varname, String: mapname, Object: defaultValue) -> Object
  - *example:* `LoadElement('varname','vars','defaultvalue')`
  - *Load the varable 'varname' from a map named 'vars', or provide 'defaultvalue' if neither is provided*

## HashedLineToString

Return a pseudo-randomly selected String value from a single line of the specified file.

- long -> HashedLineToString(String: filename) -> String

## ModuloToInteger

Return an integer value as the result of modulo division with the specified divisor.

- long -> ModuloToInteger(int: modulo) -> Integer

## Laplace


- long -> Laplace(double: mu, double: beta, String[]...: mods) -> double

## Zipf


- long -> Zipf(int: numberOfElements, double: exponent, String[]...: modslist) -> long

- int -> Zipf(int: numberOfElements, double: exponent, String[]...: modslist) -> long

- long -> Zipf(int: numberOfElements, double: exponent, String[]...: modslist) -> int

## Binomial


- long -> Binomial(int: trials, double: p, String[]...: modslist) -> long

- int -> Binomial(int: trials, double: p, String[]...: modslist) -> long

- long -> Binomial(int: trials, double: p, String[]...: modslist) -> int

## ToCqlType

Shows the compatible CQL type most associated with the incoming Java type.

- Object -> ToCqlType() -> String

## ChiSquared


- long -> ChiSquared(double: degreesOfFreedom, String[]...: mods) -> double

## Gumbel


- long -> Gumbel(double: mu, double: beta, String[]...: mods) -> double

## DivideToLongToString

This is equivalent to `Div(...)`, but returns the result after String.valueOf(...). This function is also deprecated, as it is easily replaced by other functions.

- long -> DivideToLongToString(long: divisor) -> String

## LongToString

Return the string representation of the provided long.

- long -> LongToString() -> String

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


## ListTemplate

Create a {@code List} based on two functions, the first to determine the list size, and the second to populate the list with string values. The input fed to the second function is incremented between elements.

- long -> ListTemplate(function.LongToIntFunction: sizeFunc, function.LongFunction<String>: valueFunc) -> List<String>
  - *example:* `ListTemplate(HashRange(3,7),NumberNameToString())`
  - *create a list between 3 and 7 elements, with number names as the values*

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

## LongToLocalDateDays

Days since Jan 1st 1970

- long -> LongToLocalDateDays() -> com.datastax.driver.core.LocalDate
  - *example:* `LongToLocalDateDays()`
  - *take the cycle number and turn it into a LocalDate based on days since 1970*

## ListMapper

This is an example of a mapping function that can create a list of objects from another internal mapping function. The input value for each function is incremented by one from the initial input value this this overall function.

- long -> ListMapper(int: size, String: genSpec) -> List<?>
  - *example:* `ListMapper(5,NumberNameToString())`
  - *creates a list of number names*

## ToHashedUUID

This function provides a stable hashing of the input value to a version 4 (Random) UUID.

- long -> ToHashedUUID() -> UUID

## DirectoryLines

Read each line in each matching file in a directory structure, providing one line for each time this function is called. The files are sorted at the time the function is initialized, and each line is read in order. This function does not produce the same result per cycle value. It is possible that different cycle inputs will return different inputs if the cycles are not applied in strict order. Still, this function is useful for consuming input from a set of files as input to a test or simulation.

- long -> DirectoryLines(String: basepath, String: namePattern) -> String
  - *example:* `DirectoryLines('/var/tmp/bardata', '.*')`
  - *load every line from every file in /var/tmp/bardata*

## HashedRangedToNonuniformDouble

This provides a random sample of a double in a range, without accounting for the non-uniform distribution of IEEE double representation. This means that values closer to high-precision areas of the IEEE spec will be weighted higher in the output. However, NaN and positive and negative infinity are filtered out via oversampling. Results are still stable for a given input value.

- long -> HashedRangedToNonuniformDouble(long: min, long: max) -> double

## MatchRegex

Match any input with a regular expression, and apply the associated regex replacement to it, yielding the value. If no matches occur, then the original value is passed through unchanged. Patterns and replacements are passed as even,odd pairs indexed from the 0th position. Back-references to matching groups are supported.

- String -> MatchRegex(String[]...: specs) -> String
  - *example:* `MatchRegex('.*(25|6to4).*','$1')`
  - *Match 25 or 6 to 4 and set the output to only that*
  - *example:* `MatchRegex('([0-9]+)-([0-9]+)-([0-9]+)','$1 $2 $3'`
  - *replaced dashes with spaces in a 10 digit US phone number.*

## Mod

Return the result of modulo division by the specified divisor.

- long -> Mod(long: modulo) -> long

- int -> Mod(int: modulo) -> int

- long -> Mod(int: modulo) -> int

## Scale

Scale the input to the Scale the input to the

- long -> Scale(double: scaleFactor) -> int

- int -> Scale(double: scaleFactor) -> int

## Murmur3DivToLong

Yield a long value which is the result of hashing and modulo division with the specified divisor.

- long -> Murmur3DivToLong(long: divisor) -> long

## Point

Create a Point generator which generates com.datastax.driver.dse.geometry.Point objects.

- long -> Point(double: x, double: y) -> com.datastax.driver.dse.geometry.Point

- long -> Point(double: x, function.LongToDoubleFunction: yfunc) -> com.datastax.driver.dse.geometry.Point

- long -> Point(function.LongToDoubleFunction: xfunc, double: y) -> com.datastax.driver.dse.geometry.Point

- long -> Point(function.LongToDoubleFunction: xfunc, function.LongToDoubleFunction: yfunc) -> com.datastax.driver.dse.geometry.Point

## Logistic


- long -> Logistic(double: mu, double: scale, String[]...: mods) -> double

## ThreadNumToLong

Matches a digit sequence in the current thread name and caches it in a thread local. This allows you to use any intentionally indexed thread factories to provide an analogue for concurrency. Note that once the thread number is cached, it will not be refreshed. This means you can't change the thread name and get an updated value.

- long -> ThreadNumToLong() -> long

## HashedFileExtractToString

Pseudo-randomly extract a section of a text file and return it according to some minimum and maximum extract size. The file is loaded into memory as a shared text image. It is then indexed into as a character buffer to find a pseudo-randomly sized fragment.

- long -> HashedFileExtractToString(String: fileName, int: minsize, int: maxsize) -> String
  - *example:* `HashedFileExtractToString('data/adventures.txt',100,200)`
  - *return a fragment from adventures.txt between 100 and 200 characters long*

## LineString


- long -> LineString(function.LongToIntFunction: lenfunc, function.LongFunction<com.datastax.driver.dse.geometry.Point>: pointfunc) -> com.datastax.driver.dse.geometry.LineString

- long -> LineString(function.LongToIntFunction: lenfunc, function.LongToDoubleFunction: xfunc, function.LongToDoubleFunction: yfunc) -> com.datastax.driver.dse.geometry.LineString

- long -> LineString(int: len, function.LongFunction<com.datastax.driver.dse.geometry.Point>: pointfunc) -> com.datastax.driver.dse.geometry.LineString

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

## EpochMillisToJavaLocalDate

Converts epoch millis to a java.time.{@link LocalDate} object, using either the system default timezone or the timezone provided. If the specified ZoneId is not the same as the time base of the epoch millis instant, then conversion errors will occur. Short form ZoneId values like 'CST' can be used, although US Domestic names which specify the daylight savings hours are not supported. The full list of short Ids at @see [JavaSE ZoneId Ids](https://docs.oracle.com/en/java/javase/12/docs/api/java.base/java/time/ZoneId.html#SHORT_IDS) Any timezone specifier may be used which can be read by {@link ZoneId#of(String)}

- long -> EpochMillisToJavaLocalDate() -> java.time.LocalDate
  - *example:* `EpochMillisToJavaLocalDate()`
  - *Yields the LocalDate for the system default ZoneId*

- long -> EpochMillisToJavaLocalDate(String: zoneid) -> java.time.LocalDate
  - *example:* `EpochMillisToJavaLocalDate('ECT')`
  - *Yields the LocalDate for the ZoneId entry for 'Europe/Paris'*
