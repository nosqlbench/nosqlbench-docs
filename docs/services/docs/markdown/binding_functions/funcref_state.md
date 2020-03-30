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




## LoadDouble

Load a value from a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. If the named variable is not defined, then the default value is returned. Load a value from a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. If the named variable is not defined, then the default value is returned.

- long -> LoadDouble(java.lang.String: name) -> double
  - *example:* `LoadDouble('foo')`
  - *for the current thread, load a double value from the named variable.*

- long -> LoadDouble(java.lang.String: name, double: defaultValue) -> double
  - *example:* `LoadDouble('foo',23D)`
  - *for the current thread, load a double value from the named variable,or the default value if the named variable is not defined.*

- long -> LoadDouble(java.util.function.LongFunction<java.lang.Object>: nameFunc) -> double
  - *example:* `LoadDouble(NumberNameToString())`
  - *for the current thread, load a double value from the named variable, where the variable name is provided by a function.*

- long -> LoadDouble(java.util.function.LongFunction<java.lang.Object>: nameFunc, double: defaultValue) -> double
  - *example:* `LoadDouble(NumberNameToString(),23D)`
  - *for the current thread, load a double value from the named variable,where the variable name is provided by a function, or the default value if the namedvariable is not defined.*

- java.lang.Object -> LoadDouble(java.lang.String: name) -> java.lang.Double
  - *example:* `LoadDouble('foo')`
  - *for the current thread, load a double value from the named variable.*

- java.lang.Object -> LoadDouble(java.lang.String: name, double: defaultValue) -> java.lang.Double
  - *example:* `LoadDouble('foo',23D)`
  - *for the current thread, load a double value from the named variable,or the default value if the named variable is not defined.*

- java.lang.Object -> LoadDouble(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc) -> java.lang.Double
  - *example:* `LoadDouble(NumberNameToString())`
  - *for the current thread, load a double value from the named variable, where the variable name is provided by a function.*

- java.lang.Object -> LoadDouble(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc, double: defaultValue) -> java.lang.Double
  - *example:* `LoadDouble(NumberNameToString(),23D)`
  - *for the current thread, load a double value from the named variable,where the variable name is provided by a function, or the default value if the namedvariable is not defined.*

## LoadString

Load a value from a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. If the named variable is not defined, then the default value is returned. Load a value from a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. If the named variable is not defined, then the default value is returned.

- java.lang.Object -> LoadString(java.lang.String: name) -> java.lang.String
  - *example:* `LoadString('foo','examplevalue')`
  - *for the current thread, load a String value from the named variable.*

- java.lang.Object -> LoadString(java.lang.String: name, java.lang.String: defaultValue) -> java.lang.String
  - *example:* `LoadString('foo','examplevalue')`
  - *for the current thread, load a String value from the named variable, or the default value if the named variable is not defined.*

- java.lang.Object -> LoadString(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc) -> java.lang.String
  - *example:* `LoadString(NumberNameToString(),'examplevalue')`
  - *for the current thread, load a String value from the named variable, or the default value if the named variable is not defined.*

- java.lang.Object -> LoadString(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc, java.lang.String: defaultValue) -> java.lang.String
  - *example:* `LoadString(NumberNameToString(),'examplevalue')`
  - *for the current thread, load a String value from the named variable,where the variable name is provided by a function, or the default value if the namedvariable is not defined.*

- long -> LoadString(java.lang.String: name) -> java.lang.String
  - *example:* `LoadString('foo','examplevalue')`
  - *for the current thread, load a String value from the named variable.*

- long -> LoadString(java.lang.String: name, java.lang.String: defaultValue) -> java.lang.String
  - *example:* `LoadString('foo','examplevalue')`
  - *for the current thread, load a String value from the named variable, or the default value if the named variable is not defined.*

- long -> LoadString(java.util.function.LongFunction<java.lang.Object>: nameFunc) -> java.lang.String
  - *example:* `LoadString(NumberNameToString(),'examplevalue')`
  - *for the current thread, load a String value from the named variable, or the default value if the named variable is not defined.*

- long -> LoadString(java.util.function.LongFunction<java.lang.Object>: nameFunc, java.lang.String: defaultValue) -> java.lang.String
  - *example:* `LoadString(NumberNameToString(),'examplevalue')`
  - *for the current thread, load a String value from the named variable,where the variable name is provided by a function, or the default value if the namedvariable is not defined.*

## Load

Load a named value from the per-thread state map. The previous input value will be forgotten, and the named value will replace it before the next function in the chain. Load a named value from the per-thread state map. The previous input value will be forgotten, and the named value will replace it before the next function in the chain.

- java.lang.String -> Load(java.lang.String: name) -> java.lang.String
  - *example:* `Load('foo')`
  - *for the current thread, load a String value from the named variable*

- java.lang.String -> Load(java.lang.String: name, java.lang.String: defaultvalue) -> java.lang.String
  - *example:* `Load('foo','track05')`
  - *for the current thread, load a String value from the named variable, or teh default value if the variable is not yet defined.*

- java.lang.String -> Load(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc) -> java.lang.String
  - *example:* `Load(NumberNameToString())`
  - *for the current thread, load a String value from the named variable, where the variable name is provided by a function*

- java.lang.String -> Load(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc, java.lang.String: defaultValue) -> java.lang.String
  - *example:* `Load(NumberNameToString(),'track05')`
  - *for the current thread, load a String value from the named variable, where the variable name is provided by a function, or the default value if the variable is not yet defined.*

- int -> Load(java.lang.String: name) -> int
  - *example:* `Load('foo')`
  - *for the current thread, load an int value from the named variable*

- int -> Load(java.lang.String: name, int: defaultValue) -> int
  - *example:* `Load('foo',42)`
  - *for the current thread, load an int value from the named variable, or return the default value if it is undefined.*

- int -> Load(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc) -> int
  - *example:* `Load(NumberNameToString())`
  - *for the current thread, load an int value from the named variable, where the variable name is provided by a function.*

- int -> Load(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc, int: defaultValue) -> int
  - *example:* `Load(NumberNameToString(),42)`
  - *for the current thread, load an int value from the named variable, where the variable name is provided by a function, or the default value if the named variable is undefined.*

- double -> Load(java.lang.String: name) -> double
  - *example:* `Load('foo')`
  - *for the current thread, load a double value from the named variable*

- double -> Load(java.lang.String: name, double: defaultValue) -> double
  - *example:* `Load('foo',432.0D)`
  - *for the current thread, load a double value from the named variable, or the defaultvalue if it is not yet defined.*

- double -> Load(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc) -> double
  - *example:* `Load(NumberNameToString())`
  - *for the current thread, load a double value from the named variable, where the variablename is provided by a function.*

- double -> Load(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc, double: defaultValue) -> double
  - *example:* `Load(NumberNameToString(),1234.5D)`
  - *for the current thread, load a double value from the named variable, where the variablename is provided by a function, or the default value if the named value is not yet defined.*

- long -> Load(java.lang.String: name) -> long
  - *example:* `Load('foo')`
  - *for the current thread, load a long value from the named variable*

- long -> Load(java.lang.String: name, long: defaultValue) -> long
  - *example:* `Load('foo', 423L)`
  - *for the current thread, load a long value from the named variable, or the default value if the variable is not yet defined*

- long -> Load(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc) -> long
  - *example:* `Load(NumberNameToString())`
  - *for the current thread, load a long value from the named variable, where the variable name is provided by the provided by a function.*

- long -> Load(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc, long: defaultvalue) -> long
  - *example:* `Load(NumberNameToString(),22L)`
  - *for the current thread, load a long value from the named variable, where the variable name is provided by the provided by a function, or the default value if the variable is not yet defined*

- long -> Load(java.lang.String: name) -> java.lang.Object
  - *example:* `Load('foo')`
  - *for the current thread, load an Object value from the named variable*

- long -> Load(java.util.function.LongFunction<java.lang.Object>: nameFunc) -> java.lang.Object
  - *example:* `Load(NumberNameToString())`
  - *for the current thread, load an Object value from the named variable, where the variable name is returned by the provided function*

- long -> Load(java.lang.String: name, java.lang.Object: defaultValue) -> java.lang.Object
  - *example:* `Load('foo','testvalue')`
  - *for the current thread, load an Object value from the named variable, or the default value if the variable is not yet defined.*

- long -> Load(java.util.function.LongFunction<java.lang.Object>: nameFunc, java.lang.Object: defaultValue) -> java.lang.Object
  - *example:* `Load(NumberNameToString(),'testvalue')`
  - *for the current thread, load an Object value from the named variable, where the variable name is returned by the provided function, or thedefault value if the variable is not yet defined.*

- java.lang.Object -> Load(java.lang.String: name) -> java.lang.Object
  - *example:* `Load('foo')`
  - *for the current thread, load an Object value from the named variable*

- java.lang.Object -> Load(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc) -> java.lang.Object
  - *example:* `Load(NumberNameToString())`
  - *for the current thread, load an Object value from the named variable, where the variable name is returned by the provided function*

- java.lang.Object -> Load(java.lang.String: name, java.lang.Object: defaultValue) -> java.lang.Object
  - *example:* `Load('foo','testvalue')`
  - *for the current thread, load an Object value from the named variable, or the default value if the variable is not yet defined.*

- java.lang.Object -> Load(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc, java.lang.Object: defaultValue) -> java.lang.Object
  - *example:* `Load(NumberNameToString(),'testvalue')`
  - *for the current thread, load an Object value from the named variable, where the variable name is returned by the provided function, or thedefault value if the variable is not yet defined.*

## SaveInteger

Save a value to a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. Note that the input type is not that suitable for constructing names, so this is more likely to be used in an indirect naming pattern like

```
SaveDouble(Load('id'))
```

Save a value to a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. Note that the input type is not that suitable for constructing names, so this is more likely to be used in an indirect naming pattern like

```
SaveDouble(Load('id'))
```


- int -> SaveInteger(java.lang.String: name) -> int
  - *example:* `SaveInteger('foo')`
  - *save the current integer value to a named variable in this thread.*

- int -> SaveInteger(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc) -> int
  - *example:* `SaveInteger(NumberNameToString())`
  - *save the current integer value to a named variable in this thread, where the variable name is provided by a function.*

- long -> SaveInteger(java.lang.String: name) -> int
  - *example:* `SaveInteger('foo')`
  - *save the current integer value to a named variable in this thread.*

- long -> SaveInteger(java.util.function.LongFunction<java.lang.Object>: nameFunc) -> int
  - *example:* `SaveInteger(NumberNameToString())`
  - *save the current integer value to a named variable in this thread, where the variable name is provided by a function.*

## UnsetOrLoad

Reads a long variable from the input, hashes and scales it to the unit interval 0.0d - 1.0d, then uses the result to determine whether to return UNSET.value or a loaded value.

- long -> UnsetOrLoad(double: ratio, java.lang.String: varname) -> java.lang.Object

## Clear

Clears the per-thread map which is used by the Expr function. Clears the per-thread map which is used by the Expr function.

- java.lang.Object -> Clear() -> java.lang.Object
  - *notes:* Clear all named entries from the per-thread map.

  - *example:* `Clear()`
  - *clear all thread-local variables*

- java.lang.Object -> Clear(java.lang.String[]...: names) -> java.lang.Object
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

- long -> Clear(java.lang.String[]...: names) -> long
  - *notes:* Clear the specified names from the per-thread map.
@param names The names to be removed from the map.

  - *example:* `Clear('foo')`
  - *clear the thread-local variable 'foo'*
  - *example:* `Clear('foo','bar')`
  - *clear the thread-local variables 'foo' and 'bar'*

## NullOrLoad

Reads a long variable from the input, hashes and scales it to the unit interval 0.0d - 1.0d, then uses the result to determine whether to return null object or a loaded value.

- long -> NullOrLoad(double: ratio, java.lang.String: varname) -> java.lang.Object

## Swap

Load a named value from the per-thread state map. The previous input value will be stored in the named value, and the previously stored value will be returned. A default value to return may be provided in case there was no previously stored value under the given name. Load a named value from the per-thread state map. The previous input value will be stored in the named value, and the previously stored value will be returned. A default value to return may be provided in case there was no previously stored value under the given name.

- java.lang.Object -> Swap(java.lang.String: name) -> java.lang.Object
  - *example:* `Swap('foo')`
  - *for the current thread, swap the input value with the named variable and returned the named variable*

- java.lang.Object -> Swap(java.lang.String: name, java.lang.Object: defaultValue) -> java.lang.Object
  - *example:* `Swap('foo','examplevalue')`
  - *for the current thread, swap the input value with the named variable and returned the named variable, or return the default value if the named value is not defined.*

- java.lang.Object -> Swap(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc) -> java.lang.Object
  - *example:* `Swap(NumberNameToString())`
  - *for the current thread, swap the input value with the named variable and returned the named variable, where the variable name is generated by the provided function.*

- java.lang.Object -> Swap(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc, java.lang.Object: defaultValue) -> java.lang.Object
  - *example:* `Swap(NumberNameToString(),'examplevalue')`
  - *for the current thread, swap the input value with the named variable and returned the named variable, where the variable name is generated by the provided function, or the default value if the named value is not defined.*

- long -> Swap(java.lang.String: name) -> java.lang.Object
  - *example:* `Swap('foo')`
  - *for the current thread, swap the input value with the named variable and returned the named variable*

- long -> Swap(java.lang.String: name, java.lang.Object: defaultValue) -> java.lang.Object
  - *example:* `Swap('foo','examplevalue')`
  - *for the current thread, swap the input value with the named variable and returned the named variable, or return the default value if the named value is not defined.*

- long -> Swap(java.util.function.LongFunction<java.lang.Object>: nameFunc) -> java.lang.Object
  - *example:* `Swap(NumberNameToString())`
  - *for the current thread, swap the input value with the named variable and returned the named variable, where the variable name is generated by the provided function.*

- long -> Swap(java.util.function.LongFunction<java.lang.Object>: nameFunc, java.lang.Object: defaultValue) -> java.lang.Object
  - *example:* `Swap(NumberNameToString(),'examplevalue')`
  - *for the current thread, swap the input value with the named variable and returned the named variable, where the variable name is generated by the provided function, or the default value if the named value is not defined.*

## SaveLong

Save a value to a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. Note that the input type is not that suitable for constructing names, so this is more likely to be used in an indirect naming pattern like

```
SaveDouble(Load('id'))
```

Save a value to a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. Note that the input type is not that suitable for constructing names, so this is more likely to be used in an indirect naming pattern like

```
SaveDouble(Load('id'))
```


- long -> SaveLong(java.lang.String: name) -> long
  - *example:* `SaveLong('foo')`
  - *save the current long value to a named variable in this thread.*

- long -> SaveLong(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc) -> long
  - *example:* `SaveLong(NumberNameToString())`
  - *save the current long value to a named variable in this thread, where the variable name is provided by a function.*

- long -> SaveLong(java.lang.String: name) -> long
  - *example:* `SaveLong('foo')`
  - *save the current long value to a named variable in this thread.*

- long -> SaveLong(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc) -> long
  - *example:* `SaveLong(NumberNameToString())`
  - *save the current long value to a named variable in this thread, where the variable name is provided by a function.*

## SaveDouble

Save a value to a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. Note that the input type is not that suitable for constructing names, so this is more likely to be used in an indirect naming pattern like

```
SaveDouble(Load('id'))
```

Save a value to a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. Note that the input type is not that suitable for constructing names, so this is more likely to be used in an indirect naming pattern like

```
SaveDouble(Load('id'))
```


- double -> SaveDouble(java.lang.String: name) -> double
  - *example:* `Save('foo')`
  - *save the current double value to the name 'foo' in this thread*

- double -> SaveDouble(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc) -> double
  - *example:* `Save(NumberNameToString())`
  - *save a double value to a named variable in the current thread, where the variable name is provided by a function.*

- long -> SaveDouble(java.lang.String: name) -> double
  - *example:* `Save('foo')`
  - *save the current double value to the name 'foo' in this thread*

- long -> SaveDouble(java.util.function.LongFunction<java.lang.Object>: nameFunc) -> double
  - *example:* `Save(NumberNameToString())`
  - *save a double value to a named variable in the current thread, where the variable name is provided by a function.*

## SaveString

Save a value to a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. Note that the input type is not that suitable for constructing names, so this is more likely to be used in an indirect naming pattern like

```
SaveDouble(Load('id'))
```

Save a value to a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. Note that the input type is not that suitable for constructing names, so this is more likely to be used in an indirect naming pattern like

```
SaveDouble(Load('id'))
```


- long -> SaveString(java.lang.String: name) -> java.lang.String
  - *example:* `SaveString('foo')`
  - *save the current String value to a named variable in this thread.*

- long -> SaveString(java.util.function.LongFunction<java.lang.Object>: nameFunc) -> java.lang.String
  - *example:* `SaveString(NumberNameToString())`
  - *save the current String value to a named variable in this thread, where the variable name is provided by a function.*

- java.lang.String -> SaveString(java.lang.String: name) -> java.lang.String
  - *example:* `SaveString('foo')`
  - *save the current String value to a named variable in this thread.*

- java.lang.String -> SaveString(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc) -> java.lang.String
  - *example:* `SaveString(NumberNameToString())`
  - *save the current String value to a named variable in this thread, where the variable name is provided by a function.*

## LoadInteger

Load a value from a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. If the named variable is not defined, then the default value is returned. Load a value from a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. If the named variable is not defined, then the default value is returned.

- java.lang.Object -> LoadInteger(java.lang.String: name) -> java.lang.Integer
  - *example:* `LoadInteger('foo')`
  - *for the current thread, load an integer value from the named variable.*

- java.lang.Object -> LoadInteger(java.lang.String: name, int: defaultValue) -> java.lang.Integer
  - *example:* `LoadInteger('foo',42)`
  - *for the current thread, load an integer value from the named variable, or the default value if the named variable is not defined.*

- java.lang.Object -> LoadInteger(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc) -> java.lang.Integer
  - *example:* `LoadInteger(NumberNameToString())`
  - *for the current thread, load an integer value from the named variable,where the variable name is provided by a function.*

- java.lang.Object -> LoadInteger(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc, int: defaultValue) -> java.lang.Integer
  - *example:* `LoadInteger(NumberNameToString(),42)`
  - *for the current thread, load an integer value from the named variable,where the variable name is provided by a function, or the default value if the namedvariable is not defined.*

- long -> LoadInteger(java.lang.String: name) -> int
  - *example:* `LoadInteger('foo')`
  - *for the current thread, load an integer value from the named variable.*

- long -> LoadInteger(java.lang.String: name, int: defaultValue) -> int
  - *example:* `LoadInteger('foo',42)`
  - *for the current thread, load an integer value from the named variable, or the default value if the named variable is not defined.*

- long -> LoadInteger(java.util.function.LongFunction<java.lang.Object>: nameFunc) -> int
  - *example:* `LoadInteger(NumberNameToString())`
  - *for the current thread, load an integer value from the named variable,where the variable name is provided by a function.*

- long -> LoadInteger(java.util.function.LongFunction<java.lang.Object>: nameFunc, int: defaultValue) -> int
  - *example:* `LoadInteger(NumberNameToString(),42)`
  - *for the current thread, load an integer value from the named variable,where the variable name is provided by a function, or the default value if the namedvariable is not defined.*

## LoadFloat

Load a value from a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. If the named variable is not defined, then the default value is returned. Load a value from a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. If the named variable is not defined, then the default value is returned.

- java.lang.Object -> LoadFloat(java.lang.String: name) -> java.lang.Float
  - *example:* `LoadFloat('foo')`
  - *for the current thread, load a float value from the named variable.*

- java.lang.Object -> LoadFloat(java.lang.String: name, float: defaultValue) -> java.lang.Float
  - *example:* `LoadFloat('foo',23F)`
  - *for the current thread, load a float value from the named variable,or the default value if the named variable is not defined.*

- java.lang.Object -> LoadFloat(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc) -> java.lang.Float
  - *example:* `LoadFloat(NumberNameToString())`
  - *for the current thread, load a float value from the named variable,where the variable name is provided by a function.*

- java.lang.Object -> LoadFloat(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc, float: defaultValue) -> java.lang.Float
  - *example:* `LoadFloat(NumberNameToString(),23F)`
  - *for the current thread, load a float value from the named variable,where the variable name is provided by a function, or the default value if the namedvariable is not defined.*

- long -> LoadFloat(java.lang.String: name) -> java.lang.Float
  - *example:* `LoadFloat('foo')`
  - *for the current thread, load a float value from the named variable.*

- long -> LoadFloat(java.lang.String: name, float: defaultValue) -> java.lang.Float
  - *example:* `LoadFloat('foo',23F)`
  - *for the current thread, load a float value from the named variable,or the default value if the named variable is not defined.*

- long -> LoadFloat(java.util.function.LongFunction<java.lang.Object>: nameFunc) -> java.lang.Float
  - *example:* `LoadFloat(NumberNameToString())`
  - *for the current thread, load a float value from the named variable,where the variable name is provided by a function.*

- long -> LoadFloat(java.util.function.LongFunction<java.lang.Object>: nameFunc, float: defaultValue) -> java.lang.Float
  - *example:* `LoadFloat(NumberNameToString(),23F)`
  - *for the current thread, load a float value from the named variable,where the variable name is provided by a function, or the default value if the namedvariable is not defined.*

## SaveFloat

Save a value to a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. Note that the input type is not that suitable for constructing names, so this is more likely to be used in an indirect naming pattern like

```
SaveDouble(Load('id'))
```

Save a value to a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. Note that the input type is not that suitable for constructing names, so this is more likely to be used in an indirect naming pattern like

```
SaveDouble(Load('id'))
```


- long -> SaveFloat(java.lang.String: name) -> java.lang.Float
  - *example:* `SaveFloat('foo')`
  - *save the current float value to a named variable in this thread.*

- long -> SaveFloat(java.util.function.LongFunction<java.lang.Object>: nameFunc) -> java.lang.Float
  - *example:* `SaveFloat(NumberNameToString())`
  - *save the current float value to a named variable in this thread, where the variable name is provided by a function.*

- java.lang.Float -> SaveFloat(java.lang.String: name) -> java.lang.Float
  - *example:* `SaveFloat('foo')`
  - *save the current float value to a named variable in this thread.*

- java.lang.Float -> SaveFloat(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc) -> java.lang.Float
  - *example:* `SaveFloat(NumberNameToString())`
  - *save the current float value to a named variable in this thread, where the variable name is provided by a function.*

## NullOrPass

Reads a long variable from the thread local variable map, hashes and scales it to the unit interval 0.0d - 1.0d, then uses the result to determine whether to return a null object or the input value.

- java.lang.Object -> NullOrPass(double: ratio, java.lang.String: varname) -> java.lang.Object

## Show

Show diagnostic values for the thread-local variable map. Show diagnostic values for the thread-local variable map.

- long -> Show() -> java.lang.String
  - *example:* `Show()`
  - *Show all values in a json-like format*

- long -> Show(java.lang.String[]...: names) -> java.lang.String
  - *example:* `Show('foo')`
  - *Show only the 'foo' value in a json-like format*
  - *example:* `Show('foo','bar')`
  - *Show the 'foo' and 'bar' values in a json-like format*

- java.lang.Object -> Show() -> java.lang.String
  - *example:* `Show()`
  - *Show all values in a json-like format*

- java.lang.Object -> Show(java.lang.String[]...: names) -> java.lang.String
  - *example:* `Show('foo')`
  - *Show only the 'foo' value in a json-like format*
  - *example:* `Show('foo','bar')`
  - *Show the 'foo' and 'bar' values in a json-like format*

## LoadLong

Load a value from a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. If the named variable is not defined, then the default value is returned. Load a value from a named thread-local variable, where the variable name is fixed or a generated variable name from a provided function. If the named variable is not defined, then the default value is returned.

- long -> LoadLong(java.lang.String: name) -> long
  - *example:* `LoadLong('foo',42L)`
  - *for the current thread, load a long value from the named variable.*

- long -> LoadLong(java.lang.String: name, long: defaultValue) -> long
  - *example:* `LoadLong('foo',42L)`
  - *for the current thread, load a long value from the named variable, or the default value if the named variable is not defined.*

- long -> LoadLong(java.util.function.LongFunction<java.lang.Object>: nameFunc) -> long
  - *example:* `LoadLong(NumberNameToString(),42L)`
  - *for the current thread, load a long value from the named variable,where the variable name is provided by a function.*

- long -> LoadLong(java.util.function.LongFunction<java.lang.Object>: nameFunc, long: defaultValue) -> long
  - *example:* `LoadLong(NumberNameToString(),42L)`
  - *for the current thread, load a long value from the named variable,where the variable name is provided by a function, or the default value if the namedvariable is not defined.*

- java.lang.Object -> LoadLong(java.lang.String: name) -> java.lang.Long
  - *example:* `LoadLong('foo',42L)`
  - *for the current thread, load a long value from the named variable.*

- java.lang.Object -> LoadLong(java.lang.String: name, long: defaultValue) -> java.lang.Long
  - *example:* `LoadLong('foo',42L)`
  - *for the current thread, load a long value from the named variable, or the default value if the named variable is not defined.*

- java.lang.Object -> LoadLong(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc) -> java.lang.Long
  - *example:* `LoadLong(NumberNameToString(),42L)`
  - *for the current thread, load a long value from the named variable,where the variable name is provided by a function.*

- java.lang.Object -> LoadLong(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc, long: defaultValue) -> java.lang.Long
  - *example:* `LoadLong(NumberNameToString(),42L)`
  - *for the current thread, load a long value from the named variable,where the variable name is provided by a function, or the default value if the namedvariable is not defined.*

## Save

Save the current input value at this point in the function chain to a thread-local variable name. The input value is unchanged, and available for the next function in the chain to use as-is. Save the current input value at this point in the function chain to a thread-local variable name. The input value is unchanged, and available for the next function in the chain to use as-is.

- long -> Save(java.lang.String: name) -> long
  - *example:* `Save('foo')`
  - *for the current thread, save the input object value to the named variable*

- long -> Save(java.util.function.LongFunction<java.lang.Object>: nameFunc) -> long
  - *example:* `Save(NumberNameToString())`
  - *for the current thread, save the current input object value to the named variable,where the variable name is provided by a function.*

- long -> Save(java.lang.String: name) -> long
  - *example:* `Save('foo')`
  - *save the current long value to the name 'foo' in this thread*

- long -> Save(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc) -> long
  - *example:* `Save(NumberNameToString())`
  - *save the current long value to the name generated by the function given.*

- java.lang.String -> Save(java.lang.String: name) -> java.lang.String
  - *example:* `Save('foo')`
  - *save the current String value to the name 'foo' in this thread*

- java.lang.String -> Save(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc) -> java.lang.String
  - *example:* `Save(NumberNameToString())`
  - *save the current String value to a named variable in this thread, where the variable name is provided by a function*

- java.lang.Object -> Save(java.lang.String: name) -> java.lang.Object
  - *example:* `Save('foo')`
  - *for the current thread, save the input object value to the named variable*

- java.lang.Object -> Save(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc) -> java.lang.Object
  - *example:* `Save(NumberNameToString())`
  - *for the current thread, save the current input object value to the named variable,where the variable name is provided by a function.*

- double -> Save(java.lang.String: name) -> double
  - *example:* `Save('foo')`
  - *for the current thread, save the current double value to the named variable.*

- double -> Save(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc) -> double
  - *example:* `Save(NumberNameToString())`
  - *for the current thread, save the current double value to the name 'foo' in this thread, where the variable name is provided by a function.*

- int -> Save(java.lang.String: name) -> int
  - *example:* `Save('foo')`
  - *save the current int value to the name 'foo' in this thread*

- int -> Save(java.util.function.Function<java.lang.Object,java.lang.Object>: nameFunc) -> int
  - *example:* `Save(NumberNameToString())`
  - *save the current int value to a named variable in this thread,where the variable name is provided by a function.*

## UnsetOrPass

Reads a long variable from the thread local variable map, hashes and scales it to the unit interval 0.0d - 1.0d, then uses the result to determine whether to return UNSET.value or the input value.

- java.lang.Object -> UnsetOrPass(double: ratio, java.lang.String: varname) -> java.lang.Object

