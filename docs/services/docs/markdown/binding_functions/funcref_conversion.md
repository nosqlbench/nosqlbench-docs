---
title: conversion functions
weight: 30
---

Conversion functions simply allow values of one type
to be converted to another type in an obvious way.

## DigestToByteBuffer

Computes the digest of the ByteBuffer on input and stores it in the output ByteBuffer. The digestTypes available are: MD2 MD5 SHA-1 SHA-224 SHA-256 SHA-384 SHA-512 SHA3-224 SHA3-256 SHA3-384 SHA3-512

- long -> DigestToByteBuffer(String: digestType) -> java.nio.ByteBuffer

- java.nio.ByteBuffer -> DigestToByteBuffer(String: digestType) -> java.nio.ByteBuffer

## ToFloat

Convert the input value into a float.

- long -> ToFloat(long: scale) -> Float

- long -> ToFloat() -> Float

- double -> ToFloat(double: scale) -> Float

- double -> ToFloat() -> Float

- int -> ToFloat(int: scale) -> Float

- int -> ToFloat() -> Float

- String -> ToFloat() -> Float

- Short -> ToFloat() -> Float

## ModuloToShort

Return a boolean value as the result of modulo division with the specified divisor.

- long -> ModuloToShort(long: modulo) -> Short

## ModuloToBigInt

Return a {@code BigInteger} value as the result of modulo division with the specified divisor.

- long -> ModuloToBigInt() -> java.math.BigInteger

- long -> ModuloToBigInt(long: modulo) -> java.math.BigInteger

## ToInetAddress

Convert the input value to a {@code InetAddress}

- long -> ToInetAddress() -> InetAddress

## ToBigInt

Convert the input value to a {@code BigInteger}

- long -> ToBigInt() -> java.math.BigInteger

## ToInt

Convert the input value to an int with long modulus remainder. If the scale is chosen, then the value is wrapped at this value. Otherwise, {@link Integer#MAX_VALUE} is used.

- Object -> ToInt() -> Integer

- Double -> ToInt(int: scale) -> Integer

- Double -> ToInt() -> Integer

- double -> ToInt(int: scale) -> int

- double -> ToInt() -> int

- long -> ToInt() -> int

- String -> ToInt() -> Integer

- long -> ToInt(int: scale) -> int
  - *example:* `ToInt(1000)`
  - *converts a long input value to an int between 0 and 999, inclusive*

- long -> ToInt() -> int
  - *example:* `ToInt()`
  - *converts a long input value to an int between 0 and 2147483647, inclusive *

## StringDateWrapper

This function wraps an epoch time in milliseconds into a String as specified in the format. The valid formatters are documented at @see [DateTimeFormat API Docs](https://www.joda.org/joda-time/apidocs/org/joda/time/format/DateTimeFormat.html)

- long -> StringDateWrapper(String: format) -> String

## ToMD5ByteBuffer

Converts the byte image of the input long to a MD5 digest in ByteBuffer form.

- long -> ToMD5ByteBuffer() -> java.nio.ByteBuffer
  - *example:* `MD5ByteBuffer()`
  - *convert the a input to an md5 digest of its bytes*

## ToByte

Convert the input value to a {@code Byte}.

- Float -> ToByte() -> Byte

- Float -> ToByte(int: modulo) -> Byte

- Short -> ToByte(int: scale) -> Byte

- Short -> ToByte() -> Byte

- String -> ToByte() -> Byte

- long -> ToByte() -> Byte

- long -> ToByte(int: modulo) -> Byte

- int -> ToByte() -> Byte

- int -> ToByte(int: modulo) -> Byte

- double -> ToByte() -> Byte

- double -> ToByte(int: modulo) -> Byte

## Format

Apply the Java String.format method to an incoming object. @see [Java 8 String.format(...) javadoc](https://docs.oracle.com/javase/8/docs/api/Formatter.html#syntax) Note: This function can often be quite slow, so more direct methods are generally preferrable.

- Object -> Format(String: format) -> String
  - *example:* `Format('Y')`
  - *Yield the formatted year from a Java date object.*

## ToShort

Convert the input value to a short.

- String -> ToShort() -> Short

- Float -> ToShort() -> Short

- Float -> ToShort(int: modulo) -> Short

- long -> ToShort() -> Short

- long -> ToShort(int: wrapat) -> Short
  - *notes:* This form allows for limiting the short values at a lower limit than Short.MAX_VALUE.
@param wrapat The maximum value to return.


- int -> ToShort() -> Short

- int -> ToShort(int: scale) -> Short

- double -> ToShort() -> Short

- double -> ToShort(int: modulo) -> Short

## ModuloToBigDecimal

Return a {@code BigDecimal} value as the result of modulo division with the specified divisor.

- long -> ModuloToBigDecimal() -> java.math.BigDecimal

- long -> ModuloToBigDecimal(long: modulo) -> java.math.BigDecimal

## ToDouble

Convert the input value to a double.

- long -> ToDouble() -> double

## ToLong

Convert the input value to a long.

- Float -> ToLong(long: scale) -> Long

- Float -> ToLong() -> Long

- String -> ToLong() -> Long

- double -> ToLong(long: scale) -> long

- double -> ToLong() -> long

## ToBoolean

Convert the input value to a {@code boolean}

- Float -> ToBoolean() -> Boolean

- Double -> ToBoolean() -> Boolean

- long -> ToBoolean() -> Boolean

- Integer -> ToBoolean() -> Boolean

## ModuloToByte

Return a byte value as the result of modulo division with the specified divisor.

- long -> ModuloToByte(long: modulo) -> Byte

## Flow

Combine functions into one.

This function allows you to combine multiple other functions into one. This is often useful
for constructing more sophisticated recipes, when you don't have the ability to use
control flow or non-functional forms.

The functions will be stitched together using the same logic that VirtData uses when
combining flows outside functions. That said, if the functions selected are not the right ones,
then it is possible to end up with the wrong data type at the end. To remedy this, be sure
to add input and output qualifiers, like `long->` or `->String` where
appropriate, to ensure that VirtData selects the right functions within the flow.

- long -> Flow(Object[]...: funcs) -> Object

## ToHexString

Converts the input ByteBuffer to a hexadecimal String.

- long -> ToHexString() -> String

- java.nio.ByteBuffer -> ToHexString() -> String

- java.nio.ByteBuffer -> ToHexString(boolean: useUpperCase) -> String

## MD5HexString

Computes the MD5 digest of the byte image of the input long, and returns it in hexadecimal String form.

- long -> MD5HexString() -> String
  - *example:* `MD5String()`
  - *Convert a long input to an md5 digest over its bytes, and then to a hexadecimal string.*

## LongToShort

Convert the input value from long to short.

- long -> LongToShort() -> Short

## LongToByte

Convert the input long value to a byte, with negative values masked away.

- long -> LongToByte() -> Byte

## ModuloToBoolean

Return a boolean value as the result of modulo division with the specified divisor.

- long -> ModuloToBoolean() -> Boolean

## ToByteBuffer

Convert the input value to a {@code ByteBuffer}

- String -> ToByteBuffer() -> java.nio.ByteBuffer

- int -> ToByteBuffer() -> java.nio.ByteBuffer

- long -> ToByteBuffer() -> java.nio.ByteBuffer

- Float -> ToByteBuffer() -> java.nio.ByteBuffer

- Short -> ToByteBuffer() -> java.nio.ByteBuffer

- double -> ToByteBuffer() -> java.nio.ByteBuffer

## ToString


- Float -> ToString() -> String

- long -> ToString() -> String

- long -> ToString(function.LongUnaryOperator: f) -> String

- long -> ToString(function.LongFunction<?>: f) -> String

- long -> ToString(function.Function<Long,?>: f) -> String

- long -> ToString(function.LongToIntFunction: f) -> String

- long -> ToString(function.LongToDoubleFunction: f) -> String

- long -> ToString(io.nosqlbench.virtdata.library.basics.shared.from_long.to_byte.LongToByte: f) -> String

- long -> ToString(io.nosqlbench.virtdata.library.basics.shared.from_long.to_short.LongToShort: f) -> String

- double -> ToString() -> String
  - *example:* `ToString()`
  - *map the double input value to a String*

- double -> ToString(function.DoubleUnaryOperator: df) -> String
  - *example:* `ToString(Add(5.7D))`
  - *map the double input value X to X+5.7D and then to a String*

- double -> ToString(function.DoubleFunction<Double>: df) -> String

- double -> ToString(function.Function<Double,Double>: df) -> String

- int -> ToString() -> String

## ToBase64String

Computes the Base64 representation of the byte image of the input long.

- String -> ToBase64String() -> String
  - *example:* `ToBase64String()`
  - *encode any input as Base64*

- long -> ToBase64String() -> String
  - *example:* `ToBase64String()`
  - *Convert the bytes of a long input into a base64 String*

