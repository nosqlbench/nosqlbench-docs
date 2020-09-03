---
title: flow functions
weight: 40
---

These functions help combine other functions into higher-order functions when needed.
## IntFlow

Combine multiple IntUnaryOperators into a single function.

- int -> IntFlow(function.IntUnaryOperator[]...: ops) -> int

## LongFlow

Combine multiple LongUnaryOperators into a single function.

- long -> LongFlow(function.LongUnaryOperator[]...: ops) -> long
  - *example:* `LongFlow(Add(3),Mul(6))`
  - *Create an integer operator which adds 3 and multiplies the result by 6*

## StringFlow

Combine multiple String functions together into one function.

- String -> StringFlow(function.Function<String,String>[]...: funcs) -> String

