---
title: Statistics functions
weight: 40
---

## LongStats

Provide a moving aggregate (min,max,avg,sum,count) of long values presented. This allows for sanity checks on values during prototyping, primarily. Using it for other purposes in actual workloads is not generally desirable, as this does not produce purely functional (deterministic) values.

- double -> LongStats(String: spec) -> double
  - *notes:* Given the specified statistic, provide an
updated result for all the values presented to this function's input.
@param spec One of 'min', 'max', 'count', 'avg', or 'sum'


- double -> LongStats(String: spec, Object: func, boolean: truncate) -> double
  - *notes:* Given the specified statistic, a function, and whether to allow truncating conversions,
provide an updated result for all the values produced by the provided function when
given the input.
@param spec One of 'min', 'max', 'count', 'avg', or 'sum'
@param func Any function which can take a long or compatible input and produce a numeric value
@param truncate Whether or not to allow truncating conversions (long to int for example)


