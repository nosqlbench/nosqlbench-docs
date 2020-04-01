---
title: pre-made functions
weight: 20
---

Functions in this category are meant to provide easy grab-and-go functions that are tailored for real-world simulation.
This library will grow over time. These functions are often built directly on top of other functions in the core
libraries. However, they are provided here for simplicity in workload construction. They perform exactly the same as
their longer-form equivalents.


## LastNames

Return a pseudo-randomly sampled last name from the last US census data on last names occurring more than 100 times.

- long -> LastNames() -> String
  - *example:* `LastNames()`
  - *select a random last name based on the chance of seeing it in the census data*

- long -> LastNames(String: modifier) -> String
  - *example:* `LastNames('map')`
  - *select over the last names by probability as input varies from 1L to Long.MAX_VALUE*

## FullNames

Combines the FirstNames and LastNames functions into one that simply concatenates them with a space between. This function is a shorthand equivalent of {@code Template('{} {}', FirstNames(), LastNames())}

- long -> FullNames() -> String

## FirstNames

Return a pseudo-randomly sampled first name from the last US census data on first names occurring more than 100 times. Both male and female names are combined in this function.

- long -> FirstNames() -> String
  - *example:* `FirstNames()`
  - *select a random first name based on the chance of seeing it in the census data*

- long -> FirstNames(String: modifier) -> String
  - *example:* `FirstNames('map')`
  - *select over the first names by probability as input varies from 1L to Long.MAX_VALUE*

