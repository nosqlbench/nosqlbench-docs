---
title: collection functions
weight: 40
---

Collection functions allow you to construct Java Lists, Maps or Sets.
These functions often take the form of a higher-order function, where
the inner function definitions are called to determine the size of
the collection, the individual values to be added, etc.

## StringMap

Create a {@code Map} from a long input based on three functions, the first to determine the map size, and the second to populate the map with key objects, and the third to populate the map with value objects. The long input fed to the second and third functions is incremented between entries. Regardless of the object type provided by the second and third functions, {@link Object#toString()} is used to determine the key and value to add to the map. To create Maps of any key and value types, simply use {@link Map} with an specific key and value mapping functions.

- long -> StringMap(function.LongToIntFunction: sizeFunc, function.LongFunction<Object>: keyFunc, function.LongFunction<Object>: valueFunc) -> Map<String,String>
  - *example:* `StringMap(HashRange(3,7),NumberNameToString(),HashRange(1300,1700))`
  - *create a map of size 3-7 entries, with a key of type string and a value of type int (Integer by autoboxing)*

- long -> StringMap(function.LongFunction<Object>[]...: objfuncs) -> Map<String,String>
  - *example:* `StringMap(NumberNameToString(),HashRange(1300,1700),NumberNameToString(),HashRange(3,7))`
  - *create a map of size 2, with a specific function for each key and each value*

## Set

Create a {@code Set} from a long input based on two functions, the first to determine the set size, and the second to populate the set with object values. The input fed to the second function is incremented between elements. To create Sets of Strings from the String version of the same mapping functions, simply use {@link StringSet} instead.

- long -> Set(function.LongToIntFunction: sizeFunc, function.LongFunction<Object>: valueFunc) -> Set<Object>
  - *example:* `Set(HashRange(3,7),Add(15L))`
  - *create a set between 3 and 7 elements of Long values*

## StringList

Create a {@code List} from a long value, based on two functions, the first to determine the list size, and the second to populate the list with String values. The input fed to the second function is incremented between elements. Regardless of the object type provided by the second function, {@link Object#toString()} is used to get the value to add to the list. To create Lists of any type of object simply use {@link List} with an specific value mapping function.

- long -> StringList(function.LongToIntFunction: sizeFunc, function.LongFunction<Object>: valueFunc) -> List<String>
  - *example:* `StringList(HashRange(3,7),Add(15L))`
  - *create a list between 3 and 7 elements of String representations of Long values*

## HashedLineToStringList

Creates a List\<String\> from a list of words in a file.

- long -> HashedLineToStringList(String: filename, int: minSize, int: maxSize) -> List

## StringMapClob

Create a {@code Map} from a long input based on three functions, the first to determine the map size, and the second to populate the map with key objects, and the third to populate the map with value objects. The long input fed to the second and third functions is incremented between entries. Regardless of the object type provided by the second and third functions, {@link Object#toString()} is used to determine the key and value to add to the map. To create Maps of any key and value types, simply use {@link Map} with an specific key and value mapping functions.

- long -> StringMapClob(function.LongToIntFunction: sizeFunc, function.LongFunction<Object>: keyFunc, function.LongFunction<Object>: valueFunc) -> String
  - *example:* `StringMap(HashRange(3,7),NumberNameToString(),HashRange(1300,1700))`
  - *create a map of size 3-7 entries, with a key of type string and a value of type int (Integer by autoboxing)*

- long -> StringMapClob(function.LongFunction<Object>[]...: objfuncs) -> String
  - *example:* `StringMapClob(NumberNameToString(),HashRange(1300,1700),NumberNameToString(),HashRange(3,7))`
  - *create a map of size 2, with a specific function for each key and each value*

## StringSet

Create a {@code Set} from a long based on two functions, the first to determine the set size, and the second to populate the set with String values. The input fed to the second function is incremented between elements. Regardless of the object type provided by the second function, {@link Object#toString()} is used to get the value to add to the list. To create Sets of any type of object simply use {@link Set} with a specific value mapping function.

- long -> StringSet(function.LongToIntFunction: sizeFunc, function.LongFunction<Object>: valueFunc) -> Set<String>
  - *example:* `StringSet(HashRange(3,7),Add(15L))`
  - *create a set between 3 and 7 elements of String representations of Long values*

## HashedRangeToLongList

Create a list of longs.

- long -> HashedRangeToLongList(int: minVal, int: maxVal, int: minSize, int: maxSize) -> List<Long>

## List

Create a {@code List} from a long input based on two functions, the first to determine the list size, and the second to populate the list with object values. The input fed to the second function is incremented between elements. To directly create Lists of Strings from the String version of the same mapping functions, simply use {@link StringList} instead.

- long -> List(function.LongToIntFunction: sizeFunc, function.LongFunction<Object>: valueFunc) -> List<Object>
  - *example:* `List(HashRange(3,7),Add(15L))`
  - *create a list between 3 and 7 elements of Long values*

## HashedLineToStringSet

Return a pseudo-randomly created Set from the values in the specified file.

- long -> HashedLineToStringSet(String: filename, int: minSize, int: maxSize) -> Set<String>
  - *example:* `HashedLineToStringSet('data/variable_words.txt',2,10)`
  - *Create a set of words sized between 2 and 10 elements*

## HashedLineToStringStringMap

Create a String-String map from the specified file, ranging in size from 0 to the specified maximum.

- long -> HashedLineToStringStringMap(String: paramFile, int: maxSize) -> Map<String,String>

## Map

Create a {@code Map} from a long input based on three functions, the first to determine the map size, and the second to populate the map with key objects, and the third to populate the map with value objects. The long input fed to the second and third functions is incremented between entries. To directly create Maps with key and value Strings using the same mapping functions, simply use {@link StringMap} instead.

- long -> Map(function.LongToIntFunction: sizeFunc, function.LongFunction<Object>: keyFunc, function.LongFunction<Object>: valueFunc) -> Map<Object,Object>
  - *example:* `Map(HashRange(3,7),NumberNameToString(),HashRange(1300,1700))`
  - *create a map of size 3-7 entries, with a key of type string and a value of type int (Integer by autoboxing)*

- long -> Map(function.LongFunction<Object>[]...: objfuncs) -> Map<Object,Object>
  - *example:* `Map(NumberNameToString(),HashRange(1300,1700),NumberNameToString(),HashRange(3,7))`
  - *create a map of size 2, with a specific function for each key and each value*

