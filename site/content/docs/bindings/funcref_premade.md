---
title: pre-made functions
weight: 20
---

Functions in this category are meant to provide easy grab-and-go functions that are tailored for real-world simulation.
This library will grow over time. These functions are often built directly on top of other functions in the core
libraries. However, they are provided here for simplicity in workload construction. They perform exactly the same as
their longer-form equivalents.


## Cities

Return a valid city name.

- long -> Cities() -> String
  - *example:* `Cities()`

## CitiesByDensity

Return a city name, weighted by population density.

- long -> CitiesByDensity() -> String
  - *example:* `CitiesByDensity()`

## CitiesByPopulation

Return a city name, weighted by total population.

- long -> CitiesByPopulation() -> String
  - *example:* `CitiesByPopulation()`

## Counties

Return a valid county name.

- long -> Counties() -> String
  - *example:* `Counties()`

## CountiesByDensity

Return a county name weighted by population density.

- long -> CountiesByDensity() -> String
  - *example:* `CountiesByDensity()`

## CountiesByPopulation

Return a county name weighted by total population.

- long -> CountiesByPopulation() -> String
  - *example:* `CountiesByPopulation()`

## CountryCodes

Return a valid country code.

- long -> CountryCodes() -> String
  - *example:* `CountryCodes()`

## CountryNames

Return a valid country name.

- long -> CountryNames() -> String
  - *example:* `CountryNames()`

## FirstNames

Return a pseudo-randomly sampled first name from the last US census data on first names occurring more than 100 times. Both male and female names are combined in this function.

- long -> FirstNames() -> String
  - *example:* `FirstNames()`
  - *select a random first name based on the chance of seeing it in the census data*

- long -> FirstNames(String: modifier) -> String
  - *example:* `FirstNames('map')`
  - *select over the first names by probability as input varies from 1L to Long.MAX_VALUE*

## FullNames

Combines the FirstNames and LastNames functions into one that simply concatenates them with a space between. This function is a shorthand equivalent of {@code Template('{} {}', FirstNames(), LastNames())}

- long -> FullNames() -> String

## LastNames

Return a pseudo-randomly sampled last name from the last US census data on last names occurring more than 100 times.

- long -> LastNames() -> String
  - *example:* `LastNames()`
  - *select a random last name based on the chance of seeing it in the census data*

- long -> LastNames(String: modifier) -> String
  - *example:* `LastNames('map')`
  - *select over the last names by probability as input varies from 1L to Long.MAX_VALUE*

## NumberNameToString

Provides the spelled-out name of a number. For example, an input of 7 would yield "seven". An input of 4234 yields the value "four thousand thirty-four". The maximum value is limited at 999,999,999.

- long -> NumberNameToString() -> String

## StateCodes

Return a valid state code. (abbreviation)

- long -> StateCodes() -> String
  - *example:* `StateCodes()`

## StateCodesByDensity

Return a state code (abbreviation), weighted by population density.

- long -> StateCodesByDensity() -> String
  - *example:* `StateCodesByDensity()`

## StateCodesByPopulation

Return a state code (abbreviation), weighted by population.

- long -> StateCodesByPopulation() -> String
  - *example:* `StateCodesByPopulation()`

## StateNames

Return a valid state name.

- long -> StateNames() -> String
  - *example:* `StateNames()`

## StateNamesByDensity

Return a state name, weighted by population density.

- long -> StateNamesByDensity() -> String
  - *example:* `StateNamesByDensity()`

## StateNamesByPopulation

Return a state name, weighted by total population.

- long -> StateNamesByPopulation() -> String
  - *example:* `StateNamesByPopulation()`

## TimeZones

Return a state name, weighted by population density.

- long -> TimeZones() -> String
  - *example:* `Timezones()`

## TimeZonesByDensity

Return a state name, weighted by population density.

- long -> TimeZonesByDensity() -> String
  - *example:* `TimezonesByDensity`

## TimeZonesByPopulation

Return a state name, weighted by population.

- long -> TimeZonesByPopulation() -> String
  - *example:* `TimezonesByPopulation()`

## ToMD5ByteBuffer

Converts the byte image of the input long to a MD5 digest in ByteBuffer form.

- long -> ToMD5ByteBuffer() -> java.nio.ByteBuffer
  - *example:* `MD5ByteBuffer()`
  - *convert the input to an md5 digest of its bytes*

## ZipCodes

Return a valid zip code.

- long -> ZipCodes() -> String
  - *example:* `ZipCodes()`

## ZipCodesByDensity

Return a zip code, weighted by population density.

- long -> ZipCodesByDensity() -> String
  - *example:* `ZipCodesByDensity`

## ZipCodesByPopulation

Return a zip code, weighted by population.

- long -> ZipCodesByPopulation() -> String
  - *example:* `ZipCodesByPopulation()`

