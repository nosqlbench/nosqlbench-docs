---
title: Experimental functions
weight: 40
---

## CustomFunc955

Temporary function to test a specific nested type. This should be replaced with a general custom/tuple type aware binding function. The type supported is a CQL type: {@code map\>} Functions are required for:
* 
* map size {@code (LongToIntFunction)}
* key {@code (LongFunction)}
  * tuple field 1 {@code (LongToIntFunction)}
  * tuple field 2 {@code {LongToIntFunction)}


- long -> CustomFunc955(function.LongToIntFunction: sizefunc, function.LongFunction&lt;Object&gt;: keyfunc, function.LongToIntFunction: field1func, function.LongToIntFunction: field2func) -> Map&lt;?,?&gt;

- long -> CustomFunc955(function.LongToIntFunction: sizefunc, function.LongFunction&lt;Object&gt;: keyfunc, function.LongToIntFunction: field1func, function.LongUnaryOperator: field2func) -> Map&lt;?,?&gt;

## TokenMapFileCycle

Utility function used for advanced data generation experiments.

- int -> TokenMapFileCycle(String: filename, boolean: loopdata, boolean: ascending) -> long

## TokenMapFileNextCycle

Utility function used for advanced data generation experiments.

- int -> TokenMapFileNextCycle(String: filename, boolean: loopdata, boolean: ascending) -> long

## TokenMapFileNextToken

Utility function used for advanced data generation experiments.

- int -> TokenMapFileNextToken(String: filename, boolean: loopdata, boolean: ascending) -> long

## TokenMapFileToken

Utility function used for advanced data generation experiments.

- int -> TokenMapFileToken(String: filename, boolean: loopdata, boolean: ascending) -> long

