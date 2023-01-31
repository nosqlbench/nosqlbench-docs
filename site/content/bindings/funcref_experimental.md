---
weight: 148595647
title: TokenMapFileCycle
---
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

## TriangularStep

Compute a value which increases monotonically with respect to the cycle value.
All values for f(X+(m\>=0)) will be equal or greater than f(X). In effect, this
means that with a sequence of monotonic inputs, the results will be monotonic as
well as clustered. The values will approximate input/average, but will vary in frequency
around a simple binomial distribution.

The practical effect of this is to be able to compute a sequence of values
over inputs which can act as foreign keys, but which are effectively ordered.

### Call for Ideas

Due to the complexity of generalizing this as a pure function over other distributions,
this is the only function of this type for now. If you are interested in this problem
domain and have some suggestions for how to extend it to other distributions, please
join the project or let us know.

- long -> TriangularStep(long: average, long: variance) -> long
  - *example:* `TriangularStep(100,20)`
  - *Create a sequence of values where the average is 100, but the range of values is between 80 and 120.*
  - *example:* `TriangularStep(80,10)`
  - *Create a sequence of values where the average is 80, but the range of values is between 70 and 90.*

- long -> TriangularStep(long: average) -> long

