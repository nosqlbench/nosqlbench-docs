---
title: null functions
weight: 40
---

These functions can generate null values. When using nulls in your binding recipes, ensure that you don't generate them
in-line as inputs to other functions. This will lead to errors which interrupt your test. If you must use functions that
generate null values, ensure that they are the only or last function in a chain.

If you need to mark a field to be undefined, but _not set to null_, then use the functions which know how to yield a
VALUE.UNSET, which is a sigil constant within the VirtData runtime. These functions are correctly interpreted by
conformant drivers like the SQL driver so that they will avoid inject the named field into an operation if it has this
special value.
## UnsetIfGe

Yield VALUE.unset if the input value is greater than or equal to the specified value. Otherwise, pass the input value along.

- long -> UnsetIfGe(long: compareto) -> java.lang.Object

- double -> UnsetIfGe(double: compareto) -> java.lang.Object

## NullIfCloseTo

Returns null if the input value is within range of the specified value.

- double -> NullIfCloseTo(double: compareto, double: sigma) -> java.lang.Double

## UnsetIfWithin

Yields UNSET.value if the input value is within the specified range, inclusive. Otherwise, passes the original value along.

- double -> UnsetIfWithin(double: min, double: max) -> java.lang.Object

## UnsetIfStringEq

Yields UNSET.value if the input value is equal to the specified value. Throws an error if the input value is null. Otherwise, passes the original value along.

- java.lang.String -> UnsetIfStringEq(java.lang.String: compareto) -> java.lang.Object

## NullIfEq

Yeilds a null if the input value is equal to the specified value.

- long -> NullIfEq(long: compareto) -> java.lang.Long

- double -> NullIfEq(double: compareto) -> java.lang.Double

## NullIfGt

Yields a null if the input value is greater than the specified value.

- long -> NullIfGt(long: compareto) -> java.lang.Long

- double -> NullIfGt(double: compareto) -> java.lang.Double

## UnsetIfNullOrEmpty

Yields UNSET.value if the input value is null or empty. Otherwise, passes the original value along.

- java.lang.String -> UnsetIfNullOrEmpty() -> java.lang.Object

## Unset

Always yields the VALUE.unset value, which signals to any consumers that the value provided should be considered undefined for any operation. This is distinct from functions which return a null, which is considered an actual value to be acted upon. It is deemed an error for any downstream user of this library to do anything with VALUE.unset besides explicitly acting like it wasn't provided. That is the point of VALUE.unset. The purpose of having such a value in this library is to provide a value type to help bridge between functional flows and imperative run-times. Without such a value, it would be difficult to simulate value streams in which some of the time values are set and other times they are not.

- long -> Unset() -> java.lang.Object

## UnsetIfStringNe

Yields UNSET.value if the input String is not equal to the specified String value. Throws an error if the input value is null. Otherwise, passes the original value along.

- java.lang.String -> UnsetIfStringNe(java.lang.String: compareto) -> java.lang.Object

## NullIfLe

Yields a null if the input value is less than or equal to the specified value.

- long -> NullIfLe(long: compareto) -> java.lang.Long

- double -> NullIfLe(double: compareto) -> java.lang.Double

## NullIfWithin

Yields a null if the input value is within the specified range, inclusive.

- double -> NullIfWithin(double: min, double: max) -> java.lang.Double

## UnsetIfLt

Yield VALUE.unset if the provided value is less than the specified value, otherwise, pass the original value;

- long -> UnsetIfLt(long: compareto) -> java.lang.Object

- double -> UnsetIfLt(double: compareto) -> java.lang.Object

## UnsetOrLoad

Reads a long variable from the input, hashes and scales it to the unit interval 0.0d - 1.0d, then uses the result to determine whether to return UNSET.value or a loaded value.

- long -> UnsetOrLoad(double: ratio, java.lang.String: varname) -> java.lang.Object

## NullOrLoad

Reads a long variable from the input, hashes and scales it to the unit interval 0.0d - 1.0d, then uses the result to determine whether to return null object or a loaded value.

- long -> NullOrLoad(double: ratio, java.lang.String: varname) -> java.lang.Object

## UnsetIfGt

Yield UNSET.value if the input value is greater than the specified value. Otherwise, pass the input value along.

- long -> UnsetIfGt(long: compareto) -> java.lang.Object

- double -> UnsetIfGt(double: compareto) -> java.lang.Object

## NullIfGe

Yields a null if the input value is greater tha or equal to the specified value.

- long -> NullIfGe(long: compareto) -> java.lang.Long

- double -> NullIfGe(double: compareto) -> java.lang.Double

## UnsetIfEq

Yield UNSET.vale if the input value is equal to the specified value. Otherwise, pass the input value along.

- double -> UnsetIfEq(double: compareto) -> java.lang.Double

- long -> UnsetIfEq(long: compareto) -> java.lang.Object

## UnsetIfCloseTo

Yield VALUE.unset if the input value is close to the specified value by the sigma threshold. Otherwise, pass the input value along.

- double -> UnsetIfCloseTo(double: compareto, double: sigma) -> java.lang.Object

## NullIfEmpty

Yields a null if the input String is empty. Throws an error if the input String is null.

- java.lang.String -> NullIfEmpty() -> java.lang.String

## NullIfLt

Yields a null if the input value is equal to the specified value.

- double -> NullIfLt(double: compareto) -> java.lang.Double

- long -> NullIfLt(long: compareto) -> java.lang.Long

## NullOrPass

Reads a long variable from the thread local variable map, hashes and scales it to the unit interval 0.0d - 1.0d, then uses the result to determine whether to return a null object or the input value.

- java.lang.Object -> NullOrPass(double: ratio, java.lang.String: varname) -> java.lang.Object

## UnsetIfLe

Yield VALUE.unset if the input value is less than or equal to the specified value. Otherwise, pass the value along.

- long -> UnsetIfLe(long: compareto) -> java.lang.Object

- double -> UnsetIfLe(double: compareto) -> java.lang.Object

## UnsetIfEmpty

Yield VALUE.unset if the input String is empty. Throws an error if the input value is null. Otherwise, passes the original value along.

- java.lang.String -> UnsetIfEmpty() -> java.lang.Object

## NullIfNullOrEmpty

Yield a null value if the input String is either null or empty.

- java.lang.String -> NullIfNullOrEmpty() -> java.lang.String

## UnsetOrPass

Reads a long variable from the thread local variable map, hashes and scales it to the unit interval 0.0d - 1.0d, then uses the result to determine whether to return UNSET.value or the input value.

- java.lang.Object -> UnsetOrPass(double: ratio, java.lang.String: varname) -> java.lang.Object

