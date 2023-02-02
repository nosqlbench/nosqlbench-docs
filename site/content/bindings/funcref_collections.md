---
weight: 40
title: collection functions
---

Collection functions allow you to construct Java Lists, Maps or Sets.
These functions often take the form of a higher-order function, where
the inner function definitions are called to determine the size of
the collection, the individual values to be added, etc.

For each type of collection, there exists multiple forms which allow you to control how the provided
function arguments are used to set the values into the collection.

## Sized or Pair-wise functions

Any function in this category with `Sized` occuring in its name must be initialized with a sizing
function as an argument. For example, `ListSized(Mod(5),NumberNameToString())` will create a list
which is sized by the first function -- a list between 0 and 4 elements in this case. With an input
value of `3L`, the resulting List will contain 3 elements. With an input of `7L`, it will contain 2
elements.

Alternately, when a function does *not* contain `Sized` in its name, the arguments provided are used
as pair-wise mapping functions to the elements in the resulting collection.

Simply put, a Sized function will always require a sizing function as the first argument.

## Stepped or Hashed or Same

Any function in this category which contains `Stepped` in its name will automatically increment the
input value used for each element in the collection. For example
`ListStepped(NumberNameToString(),NumberNameToString())` will always creat a two-element List, but
the inputs to the provided functions will be i+0, i+1, where i is the input value to the ListStepped
function.

Alternately, any function in this category which contains `Hashed` in its name will automatically
hash the input value used for each element. This is useful when you want to create values within a
collection that vary significantly with respect of their common seed value. For example,
`ListHashed(NumberNameToString(),NumberNameToString(),NumberNameToString())` will always provide a
three element List with values that are not obviously related to each other. For each additional
element added to the collection, the previous input is hashed, so there is a relationship, but it
will not be obvious nor discernable for most testing purposes.

If neither `Stepped` nor `Hashed` occurs in the function name, then every element function
gets the exact value given to the main function.

## Overview of functions

All of the useful collection binding functions follow the same basic patterns above.

###  List Functions**

|               |  Same Input | Stepped Input| Hashed Input |
|---------------|----------|--------|----------|
| **Pair-wise** | ListFunctions(...)             | ListStepped(...)       | ListHashed(...)      |
| **Sized**     | ListSized(...)                 | ListSizedStepped(...)  | ListSizedHashed(...) |

The name `ListFunctions(...)` was chosen to avoid clashing with the existing `List(...)` function.

### Set Functions

The values produced by the provided element functions for Sets do not check for duplicate values.
This means that you must ensure that your element functions yield distinct values to insert into
the collection as it is being built if you want to have a particular cardinality of values in your
collection.  Overwrites are allowed, although they may not be intended in most cases.

|               | Same Input                    | Stepped Input        | Hashed Input        |
| ---           | ---                           | ---                  | ---                 |
| **Pair-wise** | SetFunctions(...)             | SetStepped(...)      | SetHashed(...)      |
| **Sized**     | SetSized(...)                 | SetSizedStepped(...) | SetSizedHashed(...) |

The name `SetFunctions(...)` was chosen to avoid clashing with the existing `Set(...)` function.

### Map Functions

The values produced by the provided element functions for Maps do not check for duplicate values.
This means that you must ensure that your element functions yield distinct keys to insert into
the collection as it is being built if you want to have a particular cardinality of values in your
collection.  Overwrites are allowed, although they may not be intended in most cases.

|               | Same Input                    | Stepped Input        | Hashed Input        |
| ---           | ---                           | ---                  | ---                 |
| **Pair-wise** | MapFunctions(...)             | MapStepped(...)      | MapHashed(...)      |
| **Sized**     | MapSized(...)                 | MapSizedStepped(...) | MapSizedHashed(...) |

The name `MapFunctions(...)` was chosen to avoid clashing with the existing `Map(...)` function.

For the key and value functions provided to a Map function, they are taken as even-odd pairs (starting
 at zero). For sized functions, the last defined key function will be used for elements past
 the size of the _key_ functions provided. The same is true for the value functions. For example,
 a call to `MapSized(3,f(...),g(...),h(...))` will use `f(...)` and `g(...)` for the first key and value,
 but from that point forward will use `h(...)` for all keys and `g(...)` for all values.
---
title: collection functions
weight: 40
---

Collection functions allow you to construct Java Lists, Maps or Sets.
These functions often take the form of a higher-order function, where
the inner function definitions are called to determine the size of
the collection, the individual values to be added, etc.

For each type of collection, there exists multiple forms which allow you to control how the provided
function arguments are used to set the values into the collection.

## Sized or Pair-wise functions

Any function in this category with `Sized` occuring in its name must be initialized with a sizing
function as an argument. For example, `ListSized(Mod(5),NumberNameToString())` will create a list
which is sized by the first function -- a list between 0 and 4 elements in this case. With an input
value of `3L`, the resulting List will contain 3 elements. With an input of `7L`, it will contain 2
elements.

Alternately, when a function does *not* contain `Sized` in its name, the arguments provided are used
as pair-wise mapping functions to the elements in the resulting collection.

Simply put, a Sized function will always require a sizing function as the first argument.

## Stepped or Hashed or Same

Any function in this category which contains `Stepped` in its name will automatically increment the
input value used for each element in the collection. For example
`ListStepped(NumberNameToString(),NumberNameToString())` will always creat a two-element List, but
the inputs to the provided functions will be i+0, i+1, where i is the input value to the ListStepped
function.

Alternately, any function in this category which contains `Hashed` in its name will automatically
hash the input value used for each element. This is useful when you want to create values within a
collection that vary significantly with respect of their common seed value. For example,
`ListHashed(NumberNameToString(),NumberNameToString(),NumberNameToString())` will always provide a
three element List with values that are not obviously related to each other. For each additional
element added to the collection, the previous input is hashed, so there is a relationship, but it
will not be obvious nor discernable for most testing purposes.

If neither `Stepped` nor `Hashed` occurs in the function name, then every element function
gets the exact value given to the main function.

## Overview of functions

All of the useful collection binding functions follow the same basic patterns above.

###  List Functions**

|               |  Same Input | Stepped Input| Hashed Input |
|---------------|----------|--------|----------|
| **Pair-wise** | ListFunctions(...)             | ListStepped(...)       | ListHashed(...)      |
| **Sized**     | ListSized(...)                 | ListSizedStepped(...)  | ListSizedHashed(...) |

The name `ListFunctions(...)` was chosen to avoid clashing with the existing `List(...)` function.

### Set Functions

The values produced by the provided element functions for Sets do not check for duplicate values.
This means that you must ensure that your element functions yield distinct values to insert into
the collection as it is being built if you want to have a particular cardinality of values in your
collection.  Overwrites are allowed, although they may not be intended in most cases.

|               | Same Input                    | Stepped Input        | Hashed Input        |
| ---           | ---                           | ---                  | ---                 |
| **Pair-wise** | SetFunctions(...)             | SetStepped(...)      | SetHashed(...)      |
| **Sized**     | SetSized(...)                 | SetSizedStepped(...) | SetSizedHashed(...) |

The name `SetFunctions(...)` was chosen to avoid clashing with the existing `Set(...)` function.

### Map Functions

The values produced by the provided element functions for Maps do not check for duplicate values.
This means that you must ensure that your element functions yield distinct keys to insert into
the collection as it is being built if you want to have a particular cardinality of values in your
collection.  Overwrites are allowed, although they may not be intended in most cases.

|               | Same Input                    | Stepped Input        | Hashed Input        |
| ---           | ---                           | ---                  | ---                 |
| **Pair-wise** | MapFunctions(...)             | MapStepped(...)      | MapHashed(...)      |
| **Sized**     | MapSized(...)                 | MapSizedStepped(...) | MapSizedHashed(...) |

The name `MapFunctions(...)` was chosen to avoid clashing with the existing `Map(...)` function.

For the key and value functions provided to a Map function, they are taken as even-odd pairs (starting
 at zero). For sized functions, the last defined key function will be used for elements past
 the size of the _key_ functions provided. The same is true for the value functions. For example,
 a call to `MapSized(3,f(...),g(...),h(...))` will use `f(...)` and `g(...)` for the first key and value,
 but from that point forward will use `h(...)` for all keys and `g(...)` for all values.
## HashedLineToStringList

Creates a List\<String\> from a list of words in a file.

- long -> HashedLineToStringList(String: filename, int: minSize, int: maxSize) -> List

## HashedLineToStringSet

Return a pseudo-randomly created Set from the values in the specified file.

- long -> HashedLineToStringSet(String: filename, int: minSize, int: maxSize) -> Set<String>
  - *example:* `HashedLineToStringSet('data/variable_words.txt',2,10)`
  - *Create a set of words sized between 2 and 10 elements*

## HashedLineToStringStringMap

Create a String-String map from the specified file, ranging in size from 0 to the specified maximum.

- long -> HashedLineToStringStringMap(String: paramFile, int: maxSize) -> Map<String,String>

## HashedRangeToLongList

Create a list of longs.

- long -> HashedRangeToLongList(int: minVal, int: maxVal, int: minSize, int: maxSize) -> List<Long>

## List

Create a {@code List} from a long input based on two functions, the first to determine the list size, and the second to populate the list with object values. The input fed to the second function is incremented between elements.


To directly create Lists of Strings from the String version of the same mapping functions, simply use {@link
StringList} instead.

This function is not recommended, given that the other List functions are more clear about how they construct values.
This function may be removed in the next major release, but it will be retained as deprecated for now.

- long -> List(Object: sizeFunc, Object: valueFunc) -> List<Object>
  - *example:* `List(HashRange(3,7),Add(15L))`
  - *create a list between 3 and 7 elements of Long values*

## ListFunctions

Create a List from a long input based on a set of provided functions. As a 'Pair-wise' function, the size of the resulting collection is determined directly by the number of provided element functions. As neither a 'Stepped' nor a 'Hashed' function, the input value used by each element function is the same as that provided to the outer function.

- long -> ListFunctions(Object[]...: funcs) -> List<Object>
  - *example:* `ListFunctions(NumberNameToString(),NumberNameToString(),NumberNameToString())`
  - *Create a list of object values of each function output. Produces values like ['one','one','one']*

## ListHashed

Create a List from a long input based on a set of provided functions. As a 'Pair-wise' function, the size of the resulting collection is determined directly by the number of provided element functions. As a 'Hashed' function, the input value is hashed again before being used by each element function.

- long -> ListHashed(Object[]...: funcs) -> List<Object>
  - *example:* `ListHashed(ToString(), WeightedStrings('text:1'))`
  - *Create a hash list of object values of each function output. ListHashed output ['2945182322382062539','text']*

## ListSized

Create a List from a long input based on a set of provided functions. As a 'Sized' function, the first argument is a function which determines the size of the resulting list. Additional functions provided are used to generate the elements to add to the collection. If the size is larger than the number of provided functions, the last provided function is used repeatedly as needed. As neither a 'Stepped' nor a 'Hashed' function, the input value used by each element function is the same as that provided to the outer function.

- long -> ListSized(Object: sizeFunc, Object[]...: funcs) -> List<Object>
  - *example:* `ListSized(FixedValue(5), NumberNameToString(),NumberNameToString(), WeightedStrings('text:1'))`
  - *Create a sized list of object values of each function output. List size function will recursively call the last function tillend of the list size functions*

- long -> ListSized(int: size, Object[]...: funcs) -> List<Object>

## ListSizedHashed

Create a List from a long input based on a set of provided functions. As a 'Sized' function, the first argument is a function which determines the size of the resulting list. Additional functions provided are used to generate the elements to add to the collection. If the size is larger than the number of provided functions, the last provided function is used repeatedly as needed. As a 'Hashed' function, the input value is hashed again before being used by each element function.

- long -> ListSizedHashed(Object: sizeFunc, Object[]...: funcs) -> List<Object>
  - *example:* `ListSizedHashed(FixedValue(5),long->ToString(),long->WeightedStrings('text:1'),long->ToString())`
  - *Create a sized hash list of object values of each function output. List size function will recursively call the last function tillend of the list size functions*

- long -> ListSizedHashed(int: size, Object[]...: funcs) -> List<Object>

## ListSizedStepped

Create a List from a long input based on a set of provided functions. As a 'Sized' function, the first argument is a function which determines the size of the resulting list. Additional functions provided are used to generate the elements to add to the collection. If the size is larger than the number of provided functions, the last provided function is used repeatedly as needed. As a 'Stepped' function, the input value is incremented before being used by each element function.

- long -> ListSizedStepped(Object: sizeFunc, Object[]...: funcs) -> List<Object>
  - *example:* `ListFunctions(NumberNameToString(),NumberNameToString())`
  - *Create a list of ['one','one']*

- long -> ListSizedStepped(int: size, Object[]...: funcs) -> List<Object>

## ListStepped

Create a List from a long input based on a set of provided functions. As a 'Pair-wise' function, the size of the resulting collection is determined directly by the number of provided element functions. As a 'Stepped' function, the input value is incremented before being used by each element function.

- long -> ListStepped(Object[]...: funcs) -> List<Object>
  - *example:* `ListStepped(NumberNameToString(),NumberNameToString())`
  - *Create a list of ['one','two']*

## Map

Create a {@code Map} from a long input based on three functions, the first to determine the map size, and the second to populate the map with key objects, and the third to populate the map with value objects. The long input fed to the second and third functions is incremented between entries. To directly create Maps with key and value Strings using the same mapping functions, simply use {@link StringMap} instead.

- long -> Map(function.LongToIntFunction: sizeFunc, function.LongFunction<Object>: keyFunc, function.LongFunction<Object>: valueFunc) -> Map<Object,Object>
  - *example:* `Map(HashRange(3,7),NumberNameToString(),HashRange(1300,1700))`
  - *create a map of size 3-7 entries, with a key of type string and a value of type int (Integer by autoboxing)*

- long -> Map(function.LongFunction<Object>[]...: objfuncs) -> Map<Object,Object>
  - *example:* `Map(NumberNameToString(),HashRange(1300,1700),NumberNameToString(),HashRange(3,7))`
  - *create a map of size 2, with a specific function for each key and each value*

## MapFunctions

Create a Map from a long input based on a set of provided key and value functions. Any duplicate entries produced by the key functions are elided. As a 'Pair-wise' function, the size of the resulting collection is determined directly by the number of provided element functions. Since this is a map, the functions come in pairs, each even numbered function is a key function and each odd numbered function is the corresponding value function. As neither a 'Stepped' nor a 'Hashed' function, the input value used by each key and value function is the same as that provided to the outer function.

- long -> MapFunctions(Object[]...: funcs) -> Map<Object,Object>
  - *example:* `MapFunctions(NumberNameToString(),NumberNameToString(),ToString(),ToString())`
  - *Create a map of object values. Produces values like {'one':'one'1:1}.*

## MapHashed

Create a Map from a long input based on a set of provided key and value functions. Any duplicate entries produced by the key functions are elided. As a 'Pair-wise' function, the size of the resulting collection is determined directly by the number of provided element functions. Since this is a map, the functions come in pairs, each even numbered function is a key function and each odd numbered function is the corresponding value function. As a 'Hashed' function, the input value is hashed again before being used by each key and value function.

- long -> MapHashed(Object[]...: funcs) -> Map<Object,Object>
  - *example:* `MapHashed(NumberNameToString(),NumberNameToString(),ToString(),ToString())`
  - *Create a map of object values. Produces values like {'one':'one','4464361019114304900','4464361019114304900'}.*

## MapSized

Create a Map from a long input based on a set of provided key and value functions. Any duplicate entries produced by the key functions are elided. As a 'Sized' function, the first argument is a function which determines the size of the resulting map. Additional functions provided are used to generate the elements to add to the collection, as in the pair-wise mode of {@link MapFunctions}. If the size is larger than the number of provided functions, the last provided function is used repeatedly as needed. (respectively for key functions as well as value functions) As neither a 'Stepped' nor a 'Hashed' function, the input value used by each key and value function is the same as that provided to the outer function.

- long -> MapSized(Object: sizeFunc, Object[]...: funcs) -> Map<Object,Object>
  - *example:* `MapSized(1, NumberNameToString(),NumberNameToString(),ToString(),ToString())`
  - *Create a map of object values. Produces values like {'one':'one'1:1}.*

- long -> MapSized(int: size, Object[]...: funcs) -> Map<Object,Object>

## MapSizedHashed

Create a Map from a long input based on a set of provided key and value functions. Any duplicate entries produced by the key functions are elided. As a 'Sized' function, the first argument is a function which determines the size of the resulting map. Additional functions provided are used to generate the elements to add to the collection, as in the pair-wise mode of {@link MapFunctions}. If the size is larger than the number of provided functions, the last provided function is used repeatedly as needed. (respectively for key functions as well as value functions) As a 'Hashed' function, the input value is hashed again before being used by each key and value function.

- long -> MapSizedHashed(Object: sizeFunc, Object[]...: funcs) -> Map<Object,Object>
  - *example:* `MapSizedHashed(1, NumberNameToString(),NumberNameToString(),ToString(),ToString())`
  - *Create a map of object values. Produces values like {'one':'one'1:1}.*
  - *example:* `MapSizedHashed(HashRange(3,5), NumberNameToString(),NumberNameToString())`
  - *Create a map of object values. Produces values like {'one':'one'1:1}.*

- long -> MapSizedHashed(int: size, Object[]...: funcs) -> Map<Object,Object>

## MapSizedStepped

Create a Map from a long input based on a set of provided key and value functions. Any duplicate entries produced by the key functions are elided. As a 'Sized' function, the first argument is a function which determines the size of the resulting map. Additional functions provided are used to generate the elements to add to the collection, as in the pair-wise mode of {@link MapFunctions}. If the size is larger than the number of provided functions, the last provided function is used repeatedly as needed. (respectively for key functions as well as value functions) As a 'Stepped' function, the input value is incremented before being used by each key or value function.

- long -> MapSizedStepped(Object: sizeFunc, Object[]...: funcs) -> Map<Object,Object>
  - *example:* `MapSizedStepped(1, NumberNameToString(),NumberNameToString())`
  - *Create a map of object values. Produces values like {'one':'one'1:1}.*

- long -> MapSizedStepped(int: size, Object[]...: funcs) -> Map<Object,Object>

## MapStepped

Create a Map from a long input based on a set of provided key and value functions. Any duplicate entries produced by the key functions are elided. As a 'Pair-wise' function, the size of the resulting collection is determined directly by the number of provided element functions. Since this is a map, the functions come in pairs, each even numbered function is a key function and each odd numbered function is the corresponding value function. As a 'Stepped' function, the input value is incremented before being used by each key or value function.

- long -> MapStepped(Object[]...: funcs) -> Map<Object,Object>
  - *example:* `MapStepped(NumberNameToString(),NumberNameToString(),ToString(),ToString())`
  - *Create a map of object values. Produces values like {'one':'one'1:1}.*

## Set

Create a {@code Set} from a long input based on two functions, the first to determine the set size, and the second to populate the set with object values. The input fed to the second function is incremented between elements.


To create Sets of Strings from the String version of the same mapping functions, simply use {@link StringSet}
instead.

- long -> Set(function.LongToIntFunction: sizeFunc, function.LongFunction<Object>: valueFunc) -> Set<Object>
  - *example:* `Set(HashRange(3,7),Add(15L))`
  - *create a set between 3 and 7 elements of Long values*

- long -> Set(function.LongToIntFunction: sizeFunc, function.LongUnaryOperator: valueFunc) -> Set<Object>

- long -> Set(function.LongToIntFunction: sizeFunc, function.LongToIntFunction: valueFunc) -> Set<Object>

- long -> Set(function.LongFunction<Object>: sizeFunc, function.LongFunction<Object>: valueFunc) -> Set<Object>

- long -> Set(function.LongFunction<Object>: sizeFunc, function.LongUnaryOperator: valueFunc) -> Set<Object>

- long -> Set(function.LongFunction<Object>: sizeFunc, function.LongToIntFunction: valueFunc) -> Set<Object>

- long -> Set(function.LongUnaryOperator: sizeFunc, function.LongFunction<Object>: valueFunc) -> Set<Object>

- long -> Set(function.LongUnaryOperator: sizeFunc, function.LongUnaryOperator: valueFunc) -> Set<Object>

- long -> Set(function.LongUnaryOperator: sizeFunc, function.LongToIntFunction: valueFunc) -> Set<Object>

## SetFunctions

Create a Set from a long input based on a set of provided functions. Any duplicate values are elided. As a 'Pair-wise' function, the size of the resulting collection is determined directly by the number of provided element functions. As neither a 'Stepped' nor a 'Hashed' function, the input value used by each element function is the same as that provided to the outer function.

- long -> SetFunctions(Object[]...: funcs) -> Set<Object>
  - *example:* `SetFunctions(NumberNameToString(),NumberNameToString(),NumberNameToString())`
  - *Create a list of object values of each function output. Produces values like ['one'], as each function produces the same value.*

## SetHashed

Create a Set from a long input based on a set of provided functions. As a 'Pair-wise' function, the size of the resulting collection is determined directly by the number of provided element functions, assuming no duplicate values. As a 'Hashed' function, the input value is hashed again before being used by each element function.

- long -> SetHashed(Object[]...: funcs) -> Set<Object>
  - *example:* `SetHashed(ToString(), WeightedStrings('text:1'))`
  - *Create a hash list of object values of each function output, like ['2945182322382062539','text']*

## SetSized

Create a Set from a long input based on a set of provided functions. As a 'Sized' function, the first argument is a function which determines the size of the resulting set. Additional functions provided are used to generate the elements to add to the collection. If the size is larger than the number of provided functions, the last provided function is used repeatedly as needed. As neither a 'Stepped' nor a 'Hashed' function, the input value used by each element function is the same as that provided to the outer function.

- long -> SetSized(Object: sizeFunc, Object[]...: funcs) -> Set<Object>
  - *example:* `SetSized(FixedValue(5), NumberNameToString(), WeightedStrings('text:1'))`
  - *Create a sized set of object values, like ['one','text'], because 'text' is duplicated 4 times*

- long -> SetSized(int: size, Object[]...: funcs) -> Set<Object>

## SetSizedHashed

Create a Set from a long input based on a set of provided functions. As a 'Sized' function, the first argument is a function which determines the size of the resulting set. Additional functions provided are used to generate the elements to add to the collection. If the size is larger than the number of provided functions, the last provided function is used repeatedly as needed. As a 'Hashed' function, the input value is hashed again before being used by each element function.

- long -> SetSizedHashed(Object: sizeFunc, Object[]...: funcs) -> Set<Object>
  - *example:* `SetSizedHashed(FixedValue(5),long->ToString(),long->WeightedStrings('text:1'),long->ToString())`
  - *Create a sized set of values like ['2945182322382062539', 'text', '37945690212757860', '287864597160630738', '3299224200079606887']*

- long -> SetSizedHashed(int: size, Object[]...: funcs) -> Set<Object>

## SetSizedStepped

Create a Set from a long input based on a set of provided functions. As a 'Sized' function, the first argument is a function which determines the size of the resulting set. Additional functions provided are used to generate the elements to add to the collection. If the size is larger than the number of provided functions, the last provided function is used repeatedly as needed. As a 'Stepped' function, the input value is incremented before being used by each element function.

- long -> SetSizedStepped(Object: sizeFunc, Object[]...: funcs) -> Set<Object>
  - *example:* `SetSizedStepped(Mod(3),NumberNameToString(),NumberNameToString())`
  - *Create a set, like ['three','four']*

- long -> SetSizedStepped(int: size, Object[]...: funcs) -> Set<Object>

## SetStepped

Create a Set from a long input based on a set of provided functions. As a 'Pair-wise' function, the size of the resulting collection is determined directly by the number of provided element functions, assuming no duplicate values. As a 'Stepped' function, the input value is incremented before being used by each element function.

- long -> SetStepped(Object[]...: funcs) -> Set<Object>
  - *example:* `SetStepped(NumberNameToString(),NumberNameToString())`
  - *Create a list of ['one','two']*

## StringList

Create a {@code List} from a long value, based on two functions, the first to determine the list size, and the second to populate the list with String values. The input fed to the second function is incremented between elements. Regardless of the object type provided by the second function, {@link Object#toString()} is used to get the value to add to the list.


To create Lists of any type of object simply use {@link List} with an specific value mapping function.

- long -> StringList(function.LongToIntFunction: sizeFunc, function.LongFunction<Object>: valueFunc) -> List<String>
  - *example:* `StringList(HashRange(3,7),Add(15L))`
  - *create a list between 3 and 7 elements of String representations of Long values*

## StringMap

Create a {@code Map} from a long input based on three functions, the first to determine the map size, and the second to populate the map with key objects, and the third to populate the map with value objects. The long input fed to the second and third functions is incremented between entries. Regardless of the object type provided by the second and third functions, {@link Object#toString()} is used to determine the key and value to add to the map. To create Maps of any key and value types, simply use {@link Map} with an specific key and value mapping functions.

- long -> StringMap(function.LongToIntFunction: sizeFunc, function.LongFunction<Object>: keyFunc, function.LongFunction<Object>: valueFunc) -> Map<String,String>
  - *example:* `StringMap(HashRange(3,7),NumberNameToString(),HashRange(1300,1700))`
  - *create a map of size 3-7 entries, with a key of type string and a value of type int (Integer by autoboxing)*

- long -> StringMap(function.LongFunction<Object>[]...: objfuncs) -> Map<String,String>
  - *example:* `StringMap(NumberNameToString(),HashRange(1300,1700),NumberNameToString(),HashRange(3,7))`
  - *create a map of size 2, with a specific function for each key and each value*

## StringSet

Create a {@code Set} from a long based on two functions, the first to determine the set size, and the second to populate the set with String values. The input fed to the second function is incremented between elements. Regardless of the object type provided by the second function, {@link Object#toString()} is used to get the value to add to the list. To create Sets of any type of object simply use {@link Set} with a specific value mapping function.

- long -> StringSet(function.LongToIntFunction: sizeFunc, function.LongFunction<Object>: valueFunc) -> Set<String>
  - *example:* `StringSet(HashRange(3,7),Add(15L))`
  - *create a set between 3 and 7 elements of String representations of Long values*

- long -> StringSet(function.LongToIntFunction: sizeFunc, function.LongUnaryOperator: valueFunc) -> Set<String>

- long -> StringSet(function.LongToIntFunction: sizeFunc, function.LongToIntFunction: valueFunc) -> Set<String>

- long -> StringSet(function.LongFunction<?>: sizeFunc, function.LongFunction<Object>: valueFunc) -> Set<String>

- long -> StringSet(function.LongFunction<?>: sizeFunc, function.LongUnaryOperator: valueFunc) -> Set<String>

- long -> StringSet(function.LongFunction<?>: sizeFunc, function.LongToIntFunction: valueFunc) -> Set<String>

- long -> StringSet(function.LongUnaryOperator: sizeFunc, function.LongFunction<Object>: valueFunc) -> Set<String>

- long -> StringSet(function.LongUnaryOperator: sizeFunc, function.LongUnaryOperator: valueFunc) -> Set<String>

- long -> StringSet(function.LongUnaryOperator: sizeFunc, function.LongToIntFunction: valueFunc) -> Set<String>

