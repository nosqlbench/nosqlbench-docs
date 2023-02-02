---
weight: 30
title: state functions
---

Functions in the state category allow you to do things with side-effects in the function flow. Specifically, they allow
you to save or load values of named variables to thread-local registers. These work best when used with non-async
activities, since the normal statement grouping allows you to share data between statements in the sequence. It is not
advised to use these with async activities.

When using these functions, be careful that you call them when needed. For example, if you have a named binding which
will save a value, that action only occurs if some statement with this named binding is used.

For example, if you have an account records and transaction records, where you want to save the account identifier to
use within the transaction inserts, you must ensure that each account binding is used within the thread first.




---
title: state functions
weight: 30
---

Functions in the state category allow you to do things with side-effects in the function flow. Specifically, they allow
you to save or load values of named variables to thread-local registers. These work best when used with non-async
activities, since the normal statement grouping allows you to share data between statements in the sequence. It is not
advised to use these with async activities.

When using these functions, be careful that you call them when needed. For example, if you have a named binding which
will save a value, that action only occurs if some statement with this named binding is used.

For example, if you have an account records and transaction records, where you want to save the account identifier to
use within the transaction inserts, you must ensure that each account binding is used within the thread first.




## Clear

Clears the per-thread map which is used by the Expr function.

- Object -> Clear() -> Object
  - *notes:* Clear all named entries from the per-thread map.

  - *example:* `Clear()`
  - *clear all thread-local variables*

- Object -> Clear(String[]...: names) -> Object
  - *notes:* Clear the specified names from the per-thread map.
@param names The names to be removed from the map.

  - *example:* `Clear('foo')`
  - *clear the thread-local variable 'foo'*
  - *example:* `Clear('foo','bar')`
  - *clear the thread-local variables 'foo' and 'bar'*

- long -> Clear() -> long
  - *notes:* Clear all named entries from the per-thread map.

  - *example:* `Clear()`
  - *clear all thread-local variables*

- long -> Clear(String[]...: names) -> long
  - *notes:* Clear the specified names from the per-thread map.
@param names The names to be removed from the map.

  - *example:* `Clear('foo')`
  - *clear the thread-local variable 'foo'*
  - *example:* `Clear('foo','bar')`
  - *clear the thread-local variables 'foo' and 'bar'*

## Load

Load a named value from the per-thread state map. The previous input value will be forgotten, and the named value will replace it before the next function in the chain.

- String -> Load(String: name) -> String
  - *example:* `Load('foo')`
  - *for the current thread, load a String value from the named variable*

- String -> Load(String: name, String: defaultvalue) -> String
  - *example:* `Load('foo','track05')`
  - *for the current thread, load a String value from the named variable, or teh default value if the variable is not yet defined.*

- String -> Load(function.Function<Object,Object>: nameFunc) -> String
  - *example:* `Load(NumberNameToString())`
  - *for the current thread, load a String value from the named variable, where the variable name is provided by a function*

- String -> Load(function.Function<Object,Object>: nameFunc, String: defaultValue) -> String
  - *example:* `Load(NumberNameToString(),'track05')`
  - *for the current thread, load a String value from the named variable, where the variable name is provided by a function, or the default value if the variable is not yet defined.*

- int -> Load(String: name) -> int
  - *example:* `Load('foo')`
  - *for the current thread, load an int value from the named variable*

- int -> Load(String: name, int: defaultValue) -> int
  - *example:* `Load('foo',42)`
  - *for the current thread, load an int value from the named variable, or return the default value if it is undefined.*

- int -> Load(function.Function<Object,Object>: nameFunc) -> int
  - *example:* `Load(NumberNameToString())`
  - *for the current thread, load an int value from the named variable, where the variable name is provided by a function.*

- int -> Load(function.Function<Object,Object>: nameFunc, int: defaultValue) -> int
  - *example:* `Load(NumberNameToString(),42)`
  - *for the current thread, load an int value from the named variable, where the variable name is provided by a function, or the default value if the named variable is undefined.*

- double -> Load(String: name) -> double
  - *example:* `Load('foo')`
  - *for the current thread, load a double value from the named variable*

- double -> Load(String: name, double: defaultValue) -> double
  - *example:* `Load('foo',432.0D)`
  - *for the current thread, load a double value from the named variable, or the defaultvalue if it is not yet defined.*

- double -> Load(function.Function<Object,Object>: nameFunc) -> double
  - *example:* `Load(NumberNameToString())`
  - *for the current thread, load a double value from the named variable, where the variablename is provided by a function.*

- double -> Load(function.Function<Object,Object>: nameFunc, double: defaultValue) -> double
  - *example:* `Load(NumberNameToString(),1234.5D)`
  - *for the current thread, load a double value from the named variable, where the variablename is provided by a function, or the default value if the named value is not yet defined.*

- long -> Load(String: name) -> long
  - *example:* `Load('foo')`
  - *for the current thread, load a long value from the named variable*

- long -> Load(String: name, long: defaultValue) -> long
  - *example:* `Load('foo', 423L)`
  - *for the current thread, load a long value from the named variable, or the default value if the variable is not yet defined*

- long -> Load(function.Function<Object,Object>: nameFunc) -> long
  - *example:* `Load(NumberNameToString())`
  - *for the current thread, load a long value from the named variable, where the variable name is provided by the provided by a function.*

- long -> Load(function.Function<Object,Object>: nameFunc, long: defaultvalue) -> long
  - *example:* `Load(NumberNameToString(),22L)`
  - *for the current thread, load a long value from the named variable, where the variable name is provided by the provided by a function, or the default value if the variable is not yet defined*

- long -> Load(String: name) -> Object
  - *example:* `Load('foo')`
  - *for the current thread, load an Object value from the named variable*

- long -> Load(function.LongFunction<Object>: nameFunc) -> Object
  - *example:* `Load(NumberNameToString())`
  - *for the current thread, load an Object value from the named variable, where the variable name is returned by the provided function*

- long -> Load(String: name, Object: defaultValue) -> Object
  - *example:* `Load('foo','testvalue')`
  - *for the current thread, load an Object value from the named variable, or the default value if the variable is not yet defined.*

- long -> Load(function.LongFunction<Object>: nameFunc, Object: defaultValue) -> Object
  - *example:* `Load(NumberNameToString(),'testvalue')`
  - *for the current thread, load an Object value from the named variable, where the variable name is returned by the provided function, or thedefault value if the variable is not yet defined.*

- Object -> Load(String: name) -> Object
  - *example:* `Load('foo')`
  - *for the current thread, load an Object value from the named variable*

- Object -> Load(function.Function<Object,Object>: nameFunc) -> Object
  - *example:* `Load(NumberNameToString())`
  - *for the current thread, load an Object value from the named variable, where the variable name is returned by the provided function*

- Object -> Load(String: name, Object: defaultValue) -> Object
  - *example:* `Load('foo','testvalue')`
  - *for the current thread, load an Object value from the named variable, or the default value if the variable is not yet defined.*

- Object -> Load(function.Function<Object,Object>: nameFunc, Object: defaultValue) -> Object
  - *example:* `Load(NumberNameToString(),'testvalue')`
  - *for the current thread, load an Object value from the named variable, where the variable name is returned by the provided function, or thedefault value if the variable is not yet defined.*

## LoadDouble

Load a value from a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. If the named variable is not defined, then the default value is returned.

- long -> LoadDouble(String: name) -> double
  - *example:* `LoadDouble('foo')`
  - *for the current thread, load a double value from the named variable.*

- long -> LoadDouble(String: name, double: defaultValue) -> double
  - *example:* `LoadDouble('foo',23D)`
  - *for the current thread, load a double value from the named variable,or the default value if the named variable is not defined.*

- long -> LoadDouble(function.LongFunction<Object>: nameFunc) -> double
  - *example:* `LoadDouble(NumberNameToString())`
  - *for the current thread, load a double value from the named variable, where the variable name is provided by a function.*

- long -> LoadDouble(function.LongFunction<Object>: nameFunc, double: defaultValue) -> double
  - *example:* `LoadDouble(NumberNameToString(),23D)`
  - *for the current thread, load a double value from the named variable,where the variable name is provided by a function, or the default value if the namedvariable is not defined.*

- Object -> LoadDouble(String: name) -> Double
  - *example:* `LoadDouble('foo')`
  - *for the current thread, load a double value from the named variable.*

- Object -> LoadDouble(String: name, double: defaultValue) -> Double
  - *example:* `LoadDouble('foo',23D)`
  - *for the current thread, load a double value from the named variable,or the default value if the named variable is not defined.*

- Object -> LoadDouble(function.Function<Object,Object>: nameFunc) -> Double
  - *example:* `LoadDouble(NumberNameToString())`
  - *for the current thread, load a double value from the named variable, where the variable name is provided by a function.*

- Object -> LoadDouble(function.Function<Object,Object>: nameFunc, double: defaultValue) -> Double
  - *example:* `LoadDouble(NumberNameToString(),23D)`
  - *for the current thread, load a double value from the named variable,where the variable name is provided by a function, or the default value if the namedvariable is not defined.*

## LoadFloat

Load a value from a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. If the named variable is not defined, then the default value is returned.

- Object -> LoadFloat(String: name) -> Float
  - *example:* `LoadFloat('foo')`
  - *for the current thread, load a float value from the named variable.*

- Object -> LoadFloat(String: name, float: defaultValue) -> Float
  - *example:* `LoadFloat('foo',23F)`
  - *for the current thread, load a float value from the named variable,or the default value if the named variable is not defined.*

- Object -> LoadFloat(function.Function<Object,Object>: nameFunc) -> Float
  - *example:* `LoadFloat(NumberNameToString())`
  - *for the current thread, load a float value from the named variable,where the variable name is provided by a function.*

- Object -> LoadFloat(function.Function<Object,Object>: nameFunc, float: defaultValue) -> Float
  - *example:* `LoadFloat(NumberNameToString(),23F)`
  - *for the current thread, load a float value from the named variable,where the variable name is provided by a function, or the default value if the namedvariable is not defined.*

- long -> LoadFloat(String: name) -> Float
  - *example:* `LoadFloat('foo')`
  - *for the current thread, load a float value from the named variable.*

- long -> LoadFloat(String: name, float: defaultValue) -> Float
  - *example:* `LoadFloat('foo',23F)`
  - *for the current thread, load a float value from the named variable,or the default value if the named variable is not defined.*

- long -> LoadFloat(function.LongFunction<Object>: nameFunc) -> Float
  - *example:* `LoadFloat(NumberNameToString())`
  - *for the current thread, load a float value from the named variable,where the variable name is provided by a function.*

- long -> LoadFloat(function.LongFunction<Object>: nameFunc, float: defaultValue) -> Float
  - *example:* `LoadFloat(NumberNameToString(),23F)`
  - *for the current thread, load a float value from the named variable,where the variable name is provided by a function, or the default value if the namedvariable is not defined.*

## LoadInteger

Load a value from a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. If the named variable is not defined, then the default value is returned.

- Object -> LoadInteger(String: name) -> Integer
  - *example:* `LoadInteger('foo')`
  - *for the current thread, load an integer value from the named variable.*

- Object -> LoadInteger(String: name, int: defaultValue) -> Integer
  - *example:* `LoadInteger('foo',42)`
  - *for the current thread, load an integer value from the named variable, or the default value if the named variable is not defined.*

- Object -> LoadInteger(function.Function<Object,Object>: nameFunc) -> Integer
  - *example:* `LoadInteger(NumberNameToString())`
  - *for the current thread, load an integer value from the named variable,where the variable name is provided by a function.*

- Object -> LoadInteger(function.Function<Object,Object>: nameFunc, int: defaultValue) -> Integer
  - *example:* `LoadInteger(NumberNameToString(),42)`
  - *for the current thread, load an integer value from the named variable,where the variable name is provided by a function, or the default value if the namedvariable is not defined.*

- long -> LoadInteger(String: name) -> int
  - *example:* `LoadInteger('foo')`
  - *for the current thread, load an integer value from the named variable.*

- long -> LoadInteger(String: name, int: defaultValue) -> int
  - *example:* `LoadInteger('foo',42)`
  - *for the current thread, load an integer value from the named variable, or the default value if the named variable is not defined.*

- long -> LoadInteger(function.LongFunction<Object>: nameFunc) -> int
  - *example:* `LoadInteger(NumberNameToString())`
  - *for the current thread, load an integer value from the named variable,where the variable name is provided by a function.*

- long -> LoadInteger(function.LongFunction<Object>: nameFunc, int: defaultValue) -> int
  - *example:* `LoadInteger(NumberNameToString(),42)`
  - *for the current thread, load an integer value from the named variable,where the variable name is provided by a function, or the default value if the namedvariable is not defined.*

## LoadLong

Load a value from a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. If the named variable is not defined, then the default value is returned.

- long -> LoadLong(String: name) -> long
  - *example:* `LoadLong('foo',42L)`
  - *for the current thread, load a long value from the named variable.*

- long -> LoadLong(String: name, long: defaultValue) -> long
  - *example:* `LoadLong('foo',42L)`
  - *for the current thread, load a long value from the named variable, or the default value if the named variable is not defined.*

- long -> LoadLong(function.LongFunction<Object>: nameFunc) -> long
  - *example:* `LoadLong(NumberNameToString(),42L)`
  - *for the current thread, load a long value from the named variable,where the variable name is provided by a function.*

- long -> LoadLong(function.LongFunction<Object>: nameFunc, long: defaultValue) -> long
  - *example:* `LoadLong(NumberNameToString(),42L)`
  - *for the current thread, load a long value from the named variable,where the variable name is provided by a function, or the default value if the namedvariable is not defined.*

- Object -> LoadLong(String: name) -> Long
  - *example:* `LoadLong('foo',42L)`
  - *for the current thread, load a long value from the named variable.*

- Object -> LoadLong(String: name, long: defaultValue) -> Long
  - *example:* `LoadLong('foo',42L)`
  - *for the current thread, load a long value from the named variable, or the default value if the named variable is not defined.*

- Object -> LoadLong(function.Function<Object,Object>: nameFunc) -> Long
  - *example:* `LoadLong(NumberNameToString(),42L)`
  - *for the current thread, load a long value from the named variable,where the variable name is provided by a function.*

- Object -> LoadLong(function.Function<Object,Object>: nameFunc, long: defaultValue) -> Long
  - *example:* `LoadLong(NumberNameToString(),42L)`
  - *for the current thread, load a long value from the named variable,where the variable name is provided by a function, or the default value if the namedvariable is not defined.*

## LoadString

Load a value from a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. If the named variable is not defined, then the default value is returned.

- Object -> LoadString(String: name) -> String
  - *example:* `LoadString('foo','examplevalue')`
  - *for the current thread, load a String value from the named variable.*

- Object -> LoadString(String: name, String: defaultValue) -> String
  - *example:* `LoadString('foo','examplevalue')`
  - *for the current thread, load a String value from the named variable, or the default value if the named variable is not defined.*

- Object -> LoadString(function.Function<Object,Object>: nameFunc) -> String
  - *example:* `LoadString(NumberNameToString(),'examplevalue')`
  - *for the current thread, load a String value from the named variable, or the default value if the named variable is not defined.*

- Object -> LoadString(function.Function<Object,Object>: nameFunc, String: defaultValue) -> String
  - *example:* `LoadString(NumberNameToString(),'examplevalue')`
  - *for the current thread, load a String value from the named variable,where the variable name is provided by a function, or the default value if the namedvariable is not defined.*

- long -> LoadString(String: name) -> String
  - *example:* `LoadString('foo','examplevalue')`
  - *for the current thread, load a String value from the named variable.*

- long -> LoadString(String: name, String: defaultValue) -> String
  - *example:* `LoadString('foo','examplevalue')`
  - *for the current thread, load a String value from the named variable, or the default value if the named variable is not defined.*

- long -> LoadString(function.LongFunction<Object>: nameFunc) -> String
  - *example:* `LoadString(NumberNameToString(),'examplevalue')`
  - *for the current thread, load a String value from the named variable, or the default value if the named variable is not defined.*

- long -> LoadString(function.LongFunction<Object>: nameFunc, String: defaultValue) -> String
  - *example:* `LoadString(NumberNameToString(),'examplevalue')`
  - *for the current thread, load a String value from the named variable,where the variable name is provided by a function, or the default value if the namedvariable is not defined.*

## NullOrLoad

Reads a long variable from the input, hashes and scales it to the unit interval 0.0d - 1.0d, then uses the result to determine whether to return null object or a loaded value.

- long -> NullOrLoad(double: ratio, String: varname) -> Object

## NullOrPass

Reads a long variable from the thread local variable map, hashes and scales it to the unit interval 0.0d - 1.0d, then uses the result to determine whether to return a null object or the input value.

- Object -> NullOrPass(double: ratio, String: varname) -> Object

## Save

Save the current input value at this point in the function chain to a thread-local variable name. The input value is unchanged, and available for the next function in the chain to use as-is.

- long -> Save(String: name) -> long
  - *example:* `Save('foo')`
  - *for the current thread, save the input object value to the named variable*

- long -> Save(function.LongFunction<Object>: nameFunc) -> long
  - *example:* `Save(NumberNameToString())`
  - *for the current thread, save the current input object value to the named variable,where the variable name is provided by a function.*

- long -> Save(String: name) -> long
  - *example:* `Save('foo')`
  - *save the current long value to the name 'foo' in this thread*

- long -> Save(function.Function<Object,Object>: nameFunc) -> long
  - *example:* `Save(NumberNameToString())`
  - *save the current long value to the name generated by the function given.*

- String -> Save(String: name) -> String
  - *example:* `Save('foo')`
  - *save the current String value to the name 'foo' in this thread*

- String -> Save(function.Function<Object,Object>: nameFunc) -> String
  - *example:* `Save(NumberNameToString())`
  - *save the current String value to a named variable in this thread, where the variable name is provided by a function*

- Object -> Save(String: name) -> Object
  - *example:* `Save('foo')`
  - *for the current thread, save the input object value to the named variable*

- Object -> Save(function.Function<Object,Object>: nameFunc) -> Object
  - *example:* `Save(NumberNameToString())`
  - *for the current thread, save the current input object value to the named variable,where the variable name is provided by a function.*

- double -> Save(String: name) -> double
  - *example:* `Save('foo')`
  - *for the current thread, save the current double value to the named variable.*

- double -> Save(function.Function<Object,Object>: nameFunc) -> double
  - *example:* `Save(NumberNameToString())`
  - *for the current thread, save the current double value to the name 'foo' in this thread, where the variable name is provided by a function.*

- int -> Save(String: name) -> int
  - *example:* `Save('foo')`
  - *save the current int value to the name 'foo' in this thread*

- int -> Save(function.Function<Object,Object>: nameFunc) -> int
  - *example:* `Save(NumberNameToString())`
  - *save the current int value to a named variable in this thread,where the variable name is provided by a function.*

## SaveDouble

Save a value to a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. Note that the input type is not that suitable for constructing names, so this is more likely to be used in an indirect naming pattern like SaveDouble(Load('id'))

- double -> SaveDouble(String: name) -> double
  - *example:* `Save('foo')`
  - *save the current double value to the name 'foo' in this thread*

- double -> SaveDouble(function.Function<Object,Object>: nameFunc) -> double
  - *example:* `Save(NumberNameToString())`
  - *save a double value to a named variable in the current thread, where the variable name is provided by a function.*

- long -> SaveDouble(String: name) -> double
  - *example:* `Save('foo')`
  - *save the current double value to the name 'foo' in this thread*

- long -> SaveDouble(function.LongFunction<Object>: nameFunc) -> double
  - *example:* `Save(NumberNameToString())`
  - *save a double value to a named variable in the current thread, where the variable name is provided by a function.*

## SaveFloat

Save a value to a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. Note that the input type is not that suitable for constructing names, so this is more likely to be used in an indirect naming pattern like SaveFloat(Load('id'))

- long -> SaveFloat(String: name) -> Float
  - *example:* `SaveFloat('foo')`
  - *save the current float value to a named variable in this thread.*

- long -> SaveFloat(function.LongFunction<Object>: nameFunc) -> Float
  - *example:* `SaveFloat(NumberNameToString())`
  - *save the current float value to a named variable in this thread, where the variable name is provided by a function.*

- Float -> SaveFloat(String: name) -> Float
  - *example:* `SaveFloat('foo')`
  - *save the current float value to a named variable in this thread.*

- Float -> SaveFloat(function.Function<Object,Object>: nameFunc) -> Float
  - *example:* `SaveFloat(NumberNameToString())`
  - *save the current float value to a named variable in this thread, where the variable name is provided by a function.*

## SaveInteger

Save a value to a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. Note that the input type is not that suitable for constructing names, so this is more likely to be used in an indirect naming pattern like SaveInteger(Load('id'))

- int -> SaveInteger(String: name) -> int
  - *example:* `SaveInteger('foo')`
  - *save the current integer value to a named variable in this thread.*

- int -> SaveInteger(function.Function<Object,Object>: nameFunc) -> int
  - *example:* `SaveInteger(NumberNameToString())`
  - *save the current integer value to a named variable in this thread, where the variable name is provided by a function.*

- long -> SaveInteger(String: name) -> int
  - *example:* `SaveInteger('foo')`
  - *save the current integer value to a named variable in this thread.*

- long -> SaveInteger(function.LongFunction<Object>: nameFunc) -> int
  - *example:* `SaveInteger(NumberNameToString())`
  - *save the current integer value to a named variable in this thread, where the variable name is provided by a function.*

## SaveLong

Save a value to a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. Note that the input type is not that suitable for constructing names, so this is more likely to be used in an indirect naming pattern like SaveLong(Load('id'))

- long -> SaveLong(String: name) -> long
  - *example:* `SaveLong('foo')`
  - *save the current long value to a named variable in this thread.*

- long -> SaveLong(function.Function<Object,Object>: nameFunc) -> long
  - *example:* `SaveLong(NumberNameToString())`
  - *save the current long value to a named variable in this thread, where the variable name is provided by a function.*

- long -> SaveLong(String: name) -> long
  - *example:* `SaveLong('foo')`
  - *save the current long value to a named variable in this thread.*

- long -> SaveLong(function.Function<Object,Object>: nameFunc) -> long
  - *example:* `SaveLong(NumberNameToString())`
  - *save the current long value to a named variable in this thread, where the variable name is provided by a function.*

## SaveString

Save a value to a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. Note that the input type is not that suitable for constructing names, so this is more likely to be used in an indirect naming pattern like SaveString(Load('id'))

- long -> SaveString(String: name) -> String
  - *example:* `SaveString('foo')`
  - *save the current String value to a named variable in this thread.*

- long -> SaveString(function.LongFunction<Object>: nameFunc) -> String
  - *example:* `SaveString(NumberNameToString())`
  - *save the current String value to a named variable in this thread, where the variable name is provided by a function.*

- String -> SaveString(String: name) -> String
  - *example:* `SaveString('foo')`
  - *save the current String value to a named variable in this thread.*

- String -> SaveString(function.Function<Object,Object>: nameFunc) -> String
  - *example:* `SaveString(NumberNameToString())`
  - *save the current String value to a named variable in this thread, where the variable name is provided by a function.*

## Show

Show diagnostic values for the thread-local variable map.

- long -> Show() -> String
  - *example:* `Show()`
  - *Show all values in a json-like format*

- long -> Show(String[]...: names) -> String
  - *example:* `Show('foo')`
  - *Show only the 'foo' value in a json-like format*
  - *example:* `Show('foo','bar')`
  - *Show the 'foo' and 'bar' values in a json-like format*

- Object -> Show() -> String
  - *example:* `Show()`
  - *Show all values in a json-like format*

- Object -> Show(String[]...: names) -> String
  - *example:* `Show('foo')`
  - *Show only the 'foo' value in a json-like format*
  - *example:* `Show('foo','bar')`
  - *Show the 'foo' and 'bar' values in a json-like format*

## Swap

Load a named value from the per-thread state map. The previous input value will be stored in the named value, and the previously stored value will be returned. A default value to return may be provided in case there was no previously stored value under the given name.

- Object -> Swap(String: name) -> Object
  - *example:* `Swap('foo')`
  - *for the current thread, swap the input value with the named variable and returned the named variable*

- Object -> Swap(String: name, Object: defaultValue) -> Object
  - *example:* `Swap('foo','examplevalue')`
  - *for the current thread, swap the input value with the named variable and returned the named variable, or return the default value if the named value is not defined.*

- Object -> Swap(function.Function<Object,Object>: nameFunc) -> Object
  - *example:* `Swap(NumberNameToString())`
  - *for the current thread, swap the input value with the named variable and returned the named variable, where the variable name is generated by the provided function.*

- Object -> Swap(function.Function<Object,Object>: nameFunc, Object: defaultValue) -> Object
  - *example:* `Swap(NumberNameToString(),'examplevalue')`
  - *for the current thread, swap the input value with the named variable and returned the named variable, where the variable name is generated by the provided function, or the default value if the named value is not defined.*

- long -> Swap(String: name) -> Object
  - *example:* `Swap('foo')`
  - *for the current thread, swap the input value with the named variable and returned the named variable*

- long -> Swap(String: name, Object: defaultValue) -> Object
  - *example:* `Swap('foo','examplevalue')`
  - *for the current thread, swap the input value with the named variable and returned the named variable, or return the default value if the named value is not defined.*

- long -> Swap(function.LongFunction<Object>: nameFunc) -> Object
  - *example:* `Swap(NumberNameToString())`
  - *for the current thread, swap the input value with the named variable and returned the named variable, where the variable name is generated by the provided function.*

- long -> Swap(function.LongFunction<Object>: nameFunc, Object: defaultValue) -> Object
  - *example:* `Swap(NumberNameToString(),'examplevalue')`
  - *for the current thread, swap the input value with the named variable and returned the named variable, where the variable name is generated by the provided function, or the default value if the named value is not defined.*

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

## ThreadNum

Matches a digit sequence in the current thread name and caches it in a thread local. This allows you to use any intentionally indexed thread factories to provide an analogue for concurrency. Note that once the thread number is cached, it will not be refreshed. This means you can't change the thread name and get an updated value.

- long -> ThreadNum() -> int

- long -> ThreadNum() -> long

## UnsetOrLoad

Reads a long variable from the input, hashes and scales it to the unit interval 0.0d - 1.0d, then uses the result to determine whether to return UNSET.value or a loaded value.

- long -> UnsetOrLoad(double: ratio, String: varname) -> Object

## UnsetOrPass

Reads a long variable from the thread local variable map, hashes and scales it to the unit interval 0.0d - 1.0d, then uses the result to determine whether to return UNSET.value or the input value.

- Object -> UnsetOrPass(double: ratio, String: varname) -> Object

