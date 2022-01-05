---
title: datetime functions
weight: 20
---

Functions in this category know about times and dates, datetimes, seconds or millisecond epoch times, and so forth.

Some of the functions in this category are designed to allow testing of UUID types which are usually designed to avoid
determinism. This makes it possible to test systems which depend on UUIDs but which require determinism in test data.
This is strictly for testing use. Breaking the universally-unique properties of UUIDs in production systems is a bad
idea. Yet, in testing, this determinism is quite useful.

## CqlDurationFunctions

Map a long value into a CQL Duration object based on a set of field functions.

- long -> CqlDurationFunctions(Object: monthsFunc, Object: daysFunc, Object: nanosFunc) -> com.datastax.driver.core.Duration
  - *notes:* Create a CQL Duration object from the two provided field functions. The months field is always set to
zero in this form.
@param monthsFunc A function that will yield the months value
@param daysFunc A function that will yield the days value
@param nanosFunc A function that will yeild the nanos value


- long -> CqlDurationFunctions(Object: daysFunc, Object: nanosFunc) -> com.datastax.driver.core.Duration
  - *notes:* Create a CQL Duration object from the two provided field functions. The months field is always set to
zero in this form.
@param daysFunc A function that will yield the days value
@param nanosFunc A function that will yeild the nanos value


## CurrentEpochMillis

Provide the millisecond epoch time as given by

```
{@code System.currentTimeMillis()}
```

CAUTION: This does not produce deterministic test data.

- long -> CurrentEpochMillis() -> long

## DateRangeDuring

Takes an input as a reference point in epoch time, and converts it to a DateRange, with the bounds set to the lower and upper timestamps which align to the specified precision. You can use any of these precisions to control the bounds around the provided timestamp: millisecond, second, minute, hour, day, month, or year.

- long -> DateRangeDuring(String: precision) -> com.datastax.driver.dse.search.DateRange
  - *example:* `DateRangeDuring('millisecond')}`
  - *Convert the incoming millisecond to an equivalent DateRange*
  - *example:* `DateRangeDuring('minute')}`
  - *Convert the incoming millisecond to a DateRange for the minute in which the millisecond falls*

## DateRangeFunc

Uses the precision and the two functions provided to create a DateRange. You can use any of these precisions to control the bounds around the provided timestamp: millisecond, second, minute, hour, day, month, or year.

- long -> DateRangeFunc(String: precision, function.LongUnaryOperator: lower, function.LongUnaryOperator: upper) -> com.datastax.driver.dse.search.DateRange
  - *example:* `StartingEpochMillis('2017-01-01 23:59:59'); DateRangeFunc('second',Identity(),Add(3600000L)`
  - *Create 1-minute date ranges starting at 2017-01-01 23:59:59*

- long -> DateRangeFunc(String: precision, function.LongFunction<Long>: lower, function.LongFunction<Long>: upper) -> com.datastax.driver.dse.search.DateRange

- long -> DateRangeFunc(String: precision, function.Function<Long,Long>: lower, function.Function<Long,Long>: upper) -> com.datastax.driver.dse.search.DateRange

- long -> DateRangeFunc(String: precision, function.LongUnaryOperator: lower, function.Function<Long,Long>: upper) -> com.datastax.driver.dse.search.DateRange

- long -> DateRangeFunc(String: precision, function.LongFunction<Long>: lower, function.LongUnaryOperator: upper) -> com.datastax.driver.dse.search.DateRange

- long -> DateRangeFunc(String: precision, function.Function<Long,Long>: lower, function.LongFunction<Long>: upper) -> com.datastax.driver.dse.search.DateRange

- long -> DateRangeFunc(String: precision, function.LongUnaryOperator: lower, function.LongFunction<Long>: upper) -> com.datastax.driver.dse.search.DateRange

- long -> DateRangeFunc(String: precision, function.LongFunction<Long>: lower, function.Function<Long,Long>: upper) -> com.datastax.driver.dse.search.DateRange

- long -> DateRangeFunc(String: precision, function.Function<Long,Long>: lower, function.LongUnaryOperator: upper) -> com.datastax.driver.dse.search.DateRange

## DateRangeOnOrAfter

Takes an input as a reference point in epoch time, and converts it to a DateRange, with the lower bounds set to the lower bound of the precision and millisecond provided, and with no upper bound. You can use any of these precisions to control the bounds around the provided timestamp: millisecond, second, minute, hour, day, month, or year.

- long -> DateRangeOnOrAfter(String: precision) -> com.datastax.driver.dse.search.DateRange
  - *example:* `DateRangeOnOrAfter('millisecond')}`
  - *Convert the incoming millisecond to an match any time on or after*
  - *example:* `DateRangeOnOrAfter('minute')}`
  - *Convert the incoming millisecond to mach any time on or after the minute in which the millisecond falls*

## DateRangeOnOrBefore

Takes an input as a reference point in epoch time, and converts it to a DateRange, with the upper bound set to the upper bound of the precision and millisecond provided, and with no lower bound. You can use any of these precisions to control the bounds around the provided timestamp: millisecond, second, minute, hour, day, month, or year.

- long -> DateRangeOnOrBefore(String: precision) -> com.datastax.driver.dse.search.DateRange
  - *example:* `DateRangeOnOrBefore('millisecond')}`
  - *Convert the incoming millisecond to match anything on or before it.*
  - *example:* `DateRangeOnOrBefore('minute')}`
  - *Convert the incoming millisecond to match anything on or before the minute in which the millisecond falls*

## DateRangeParser

Parses the DateRange format according to [Date Range Formatting](https://lucene.apache.org/solr/guide/6_6/working-with-dates
.html#WorkingwithDates-DateRangeFormatting). When possible it is more efficient to use the other DateRange methods since they do not require parsing.

- String -> DateRangeParser(String: precision) -> com.datastax.driver.dse.search.DateRange
  - *example:* `DateRangeParser()}`
  - *Convert inputs like '[1970-01-01T00:00:00 TO 1970-01-01T00:00:00]' into DateRanges *

## DateTimeParser

This function will parse a String containing a formatted date time, yielding a DateTime object. If no arguments are provided, then the format is set to "yyyy-MM-dd HH:mm:ss.SSSZ". For details on formatting options, see @see [DateTimeFormat](https://www.joda.org/joda-time/apidocs/org/joda/time/format/DateTimeFormat.html)

- String -> DateTimeParser() -> org.joda.time.DateTime
  - *notes:* Initialize the parser with the default pattern of <pre>yyyy-MM-dd HH:mm:ss.SSSZ</pre>.

  - *example:* `DateTimeParser()`
  - *parse any date in the yyyy-MM-dd HH:mm:ss.SSSZ format*

- String -> DateTimeParser(String: dateTimePattern) -> org.joda.time.DateTime
  - *notes:* Initialize the parser with the given pattern. With this form, if any input fails to parse,
or is null or empty, then an exception is thrown.
@param dateTimePattern The pattern which represents the incoming format.

  - *example:* `DateTimeParser('yyyy-MM-dd')`
  - *parse any date in the yyyy-MM-dd format*

- String -> DateTimeParser(String: dateTimePattern, String: defaultTime) -> org.joda.time.DateTime
  - *notes:* Initialize the parser with the given pattern and default value. In this form, if any
input fails to parse, then exceptions are suppressed and the default is provided instead.
At initialization, the default is parsed as a sanity check.
@param dateTimePattern The pattern which represents the incoming format.
@param defaultTime An example of a formatted datetime string which is used as a default.

  - *example:* `DateTimeParser('yyyy-MM-dd','1999-12-31')`
  - *parse any date in the yyyy-MM-dd format, or return the DateTime represented by 1999-12-31*

## EpochMillisToCqlLocalDate

Converts epoch millis to a com.datastax.driver.core.{@link LocalDate} object, as the number of milliseconds since January 1st, 1970 GMT.

- long -> EpochMillisToCqlLocalDate() -> com.datastax.driver.core.LocalDate
  - *example:* `EpochMillisToJavaLocalDate()`
  - *Yields the LocalDate for the millis in GMT*

## EpochMillisToJavaLocalDate

Converts epoch millis to a java.time.{@link LocalDate} object, using either the system default timezone or the timezone provided. If the specified ZoneId is not the same as the time base of the epoch millis instant, then conversion errors will occur. Short form ZoneId values like 'CST' can be used, although US Domestic names which specify the daylight savings hours are not supported. The full list of short Ids at @see [JavaSE ZoneId Ids](https://docs.oracle.com/en/java/javase/12/docs/api/java.base/java/time/ZoneId.html#SHORT_IDS) Any timezone specifier may be used which can be read by {@link ZoneId#of(String)}

- long -> EpochMillisToJavaLocalDate() -> java.time.LocalDate
  - *example:* `EpochMillisToJavaLocalDate()`
  - *Yields the LocalDate for the system default ZoneId*

- long -> EpochMillisToJavaLocalDate(String: zoneid) -> java.time.LocalDate
  - *example:* `EpochMillisToJavaLocalDate('ECT')`
  - *Yields the LocalDate for the ZoneId entry for 'Europe/Paris'*

## EpochMillisToJavaLocalDateTime

Converts epoch millis to a java.time.{@link LocalDateTime} object, using either the system default timezone or the timezone provided. If the specified ZoneId is not the same as the time base of the epoch millis instant, then conversion errors will occur. Short form ZoneId values like 'CST' can be used, although US Domestic names which specify the daylight savings hours are not supported. The full list of short Ids at @see [JavaSE ZoneId Ids](https://docs.oracle.com/en/java/javase/12/docs/api/java.base/java/time/ZoneId.html#SHORT_IDS) Any timezone specifier may be used which can be read by {@link ZoneId#of(String)}

- long -> EpochMillisToJavaLocalDateTime() -> java.time.LocalDateTime
  - *example:* `EpochMillisToJavaLocalDateTime()`
  - *Yields the LocalDateTime for the system default ZoneId*

- long -> EpochMillisToJavaLocalDateTime(String: zoneid) -> java.time.LocalDateTime
  - *example:* `EpochMillisToJavaLocalDateTime('ECT')`
  - *Yields the LocalDateTime for the ZoneId entry for 'Europe/Paris'*

## LongToLocalDateDays

Days since Jan 1st 1970

- long -> LongToLocalDateDays() -> com.datastax.driver.core.LocalDate
  - *example:* `LongToLocalDateDays()`
  - *take the cycle number and turn it into a LocalDate based on days since 1970*

## StartingEpochMillis

This function sets the minimum long value to the equivalent unix epoch time in milliseconds. It simply adds the input value to this base value as determined by the provided time specifier. It wraps any overflow within this range as well.

- long -> StartingEpochMillis(String: baseTimeSpec) -> long
  - *example:* `StartingEpochMillis('2017-01-01 23:59:59')`
  - *add the millisecond epoch time of 2017-01-01 23:59:59 to all input values*

## StringDateWrapper

This function wraps an epoch time in milliseconds into a String as specified in the format. The valid formatters are documented at @see [DateTimeFormat API Docs](https://www.joda.org/joda-time/apidocs/org/joda/time/format/DateTimeFormat.html)

- long -> StringDateWrapper(String: format) -> String

## ToCqlDurationNanos

Convert the input value into a {@link com.datastax.driver.core.Duration} by reading the input as total nanoseconds, assuming 30-month days.

- long -> ToCqlDurationNanos() -> com.datastax.driver.core.Duration

## ToDate

Convert the input value to a {@code Date}, by multiplying and then dividing the input by the provided parameters.

- long -> ToDate(int: millis_multiplier, int: millis_divisor) -> Date
  - *example:* `ToDate(86400000,2)`
  - *produce two Date values per day*

- long -> ToDate(int: spacing) -> Date
  - *example:* `ToDate(86400000)`
  - *produce a single Date() per day*

- long -> ToDate() -> Date

## ToDateTime

Convert the input value to a {@code org.joda.time.DateTime}

- long -> ToDateTime(int: spacing, int: repeat_count) -> org.joda.time.DateTime

- long -> ToDateTime(String: spacing) -> org.joda.time.DateTime

- long -> ToDateTime() -> org.joda.time.DateTime

## ToEpochTimeUUID

Converts a long UTC timestamp in epoch millis form into a Version 1 TimeUUID according to [RFC 4122](https://www.ietf.org/rfc/rfc4122.txt). This means that only one unique value for a timeuuid can be generated for each epoch milli value, even though version 1 TimeUUIDs can normally represent up to 10000 distinct values per millisecond. If you need to access this level of resolution for testing purposes, use {@link ToFinestTimeUUID} instead. This method is to support simple mapping to natural timestamps as we often find in the real world.


For the variants that have a String argument in the constructor, this is
a parsable datetime that is used as the base time for all produced values.
Setting this allows you to set the start of the time range for all timeuuid
values produced. All times are parsed for UTC. All time use ISO date ordering,
meaning that the most significant fields always go before the others.


The valid formats, in joda specifier form are:

1. yyyy-MM-dd HH:mm:ss.SSSZ, for example: 2015-02-28 23:30:15.223
2. yyyy-MM-dd HH:mm:ss, for example 2015-02-28 23:30:15
3. yyyyMMdd'T'HHmmss.SSSZ, for example: 20150228T233015.223
4. yyyyMMdd'T'HHmmssZ, for example: 20150228T233015
5. yyyy-MM-dd, for example: 2015-02-28
6. yyyyMMdd, for example: 20150228
7. yyyyMM, for example: 201502
8. yyyy, for example: 2015

- long -> ToEpochTimeUUID() -> UUID
  - *notes:* Create version 1 timeuuids with a per-host node and empty clock data.
The node and clock components are seeded from network interface data. In this case,
the clock data is not seeded uniquely.

  - *example:* `ToEpochTimeUUID()`
  - *basetime 0, computed node data, empty clock data*

- long -> ToEpochTimeUUID(long: node) -> UUID
  - *notes:* Create version 1 timeuuids with a specific static node and empty clock data.
This is useful for testing so that you can know that values are verifiable, even though
in non-testing practice, you would rely on some form of entropy per-system to provide
more practical dispersion of values over reboots, etc.

@param node a fixture value for testing that replaces node and clock bits

  - *example:* `ToEpochTimeUUID(5234)`
  - *basetime 0, specified node data (5234), empty clock data*

- long -> ToEpochTimeUUID(long: node, long: clock) -> UUID
  - *notes:* Create version 1 timeuuids with a specific static node and specific clock data.
This is useful for testing so that you can know that values are verifiable, even though
in non-testing practice, you would rely on some form of entropy per-system to provide
more practical dispersion of values over reboots, etc.

@param node  a fixture value for testing that replaces node bits
@param clock a fixture value for testing that replaces clock bits

  - *example:* `ToEpochTimeUUID(31,337)`
  - *basetime 0, specified node data (31) and clock data (337)*

- long -> ToEpochTimeUUID(String: baseSpec) -> UUID
  - *notes:* Create version 1 timeuuids with a per-host node and empty clock data.
The node and clock components are seeded from network interface data. In this case,
the clock data is not seeded uniquely.

@param baseSpec - a string specification for the base time value

  - *example:* `ToEpochTimeUUID('2017-01-01T23:59:59')`
  - *specified basetime, computed node data, empty clock data*

- long -> ToEpochTimeUUID(String: baseSpec, long: node) -> UUID
  - *notes:* Create version 1 timeuuids with a specific static node and empty clock data.
This is useful for testing so that you can know that values are verifiable, even though
in non-testing practice, you would rely on some form of entropy per-system to provide
more practical dispersion of values over reboots, etc.

@param baseSpec - a string specification for the base time value
@param node     a fixture value for testing that replaces node and clock bits

  - *example:* `ToEpochTimeUUID('2012',12345)`
  - *basetime at start if 2012, with node data 12345, empty clock data*

- long -> ToEpochTimeUUID(String: baseSpec, long: node, long: clock) -> UUID
  - *notes:* Create version 1 timeuuids with a specific static node and specific clock data.
This is useful for testing so that you can know that values are verifiable, even though
in non-testing practice, you would rely on some form of entropy per-system to provide
more practical dispersion of values over reboots, etc.

@param baseSpec - a string specification for the base time value
@param node     a fixture value for testing that replaces node bits
@param clock    a fixture value for testing that replaces clock bits

  - *example:* `ToEpochTimeUUID('20171231T1015.243',123,456)`
  - *ms basetime, specified node and clock data*

## ToFinestTimeUUID

Converts a count of 100ns intervals from 1582 Julian to a Type1 TimeUUID according to [RFC 4122](https://www.ietf.org/rfc/rfc4122.txt). This allows you to access the finest unit of resolution for the purposes of simulating a large set of unique timeuuid values. This offers 10000 times more unique values per ms than {@link ToEpochTimeUUID}. For the variants that have a String argument in the constructor, this is a parsable datetime that is used as the base time for all produced values. Setting this allows you to set the start of the time range for all timeuuid values produced. All times are parsed for UTC. All time use ISO date ordering, meaning that the most significant fields always go before the others. The valid formats, in joda specifier form are:

1. yyyy-MM-dd HH:mm:ss.SSSZ, for example: 2015-02-28 23:30:15.223
2. yyyy-MM-dd HH:mm:ss, for example 2015-02-28 23:30:15
3. yyyyMMdd'T'HHmmss.SSSZ, for example: 20150228T233015.223
4. yyyyMMdd'T'HHmmssZ, for example: 20150228T233015
5. yyyy-MM-dd, for example: 2015-02-28
6. yyyyMMdd, for example: 20150228
7. yyyyMM, for example: 201502
8. yyyy, for example: 2015

- long -> ToFinestTimeUUID() -> UUID
  - *notes:* Create version 1 timeuuids with a per-host node and empty clock data.
The node and clock components are seeded from network interface data. In this case,
the clock data is not seeded uniquely.

  - *example:* `ToFinestTimeUUID()`
  - *basetime 0, computed node data, empty clock data*

- long -> ToFinestTimeUUID(long: node) -> UUID
  - *notes:* Create version 1 timeuuids with a specific static node and empty clock data.
This is useful for testing so that you can know that values are verifiable, even though
in non-testing practice, you would rely on some form of entropy per-system to provide
more practical dispersion of values over reboots, etc.

@param node a fixture value for testing that replaces node and clock bits

  - *example:* `ToFinestTimeUUID(5234)`
  - *basetime 0, specified node data (5234), empty clock data*

- long -> ToFinestTimeUUID(long: node, long: clock) -> UUID
  - *notes:* Create version 1 timeuuids with a specific static node and specific clock data.
This is useful for testing so that you can know that values are verifiable, even though
in non-testing practice, you would rely on some form of entropy per-system to provide
more practical dispersion of values over reboots, etc.

@param node  a fixture value for testing that replaces node bits
@param clock a fixture value for testing that replaces clock bits

  - *example:* `ToFinestTimeUUID(31,337)`
  - *basetime 0, specified node data (31) and clock data (337)*

- long -> ToFinestTimeUUID(String: baseTimeSpec) -> UUID
  - *notes:* Create version 1 timeuuids with a per-host node and empty clock data.
The node and clock components are seeded from network interface data. In this case,
the clock data is not seeded uniquely.

@param baseTimeSpec - a string specification for the base time value

  - *example:* `ToFinestTimeUUID('2017-01-01T23:59:59')`
  - *specified basetime, computed node data, empty clock data*

- long -> ToFinestTimeUUID(String: baseTimeSpec, long: node) -> UUID
  - *notes:* Create version 1 timeuuids with a specific static node and empty clock data.
This is useful for testing so that you can know that values are verifiable, even though
in non-testing practice, you would rely on some form of entropy per-system to provide
more practical dispersion of values over reboots, etc.

@param baseTimeSpec - a string specification for the base time value
@param node         a fixture value for testing that replaces node and clock bits

  - *example:* `ToFinestTimeUUID('2012',12345)`
  - *basetime at start if 2012, with node data 12345, empty clock data*

- long -> ToFinestTimeUUID(String: baseTimeSpec, long: node, long: clock) -> UUID
  - *notes:* Create version 1 timeuuids with a specific static node and specific clock data.
This is useful for testing so that you can know that values are verifiable, even though
in non-testing practice, you would rely on some form of entropy per-system to provide
more practical dispersion of values over reboots, etc.

@param node         a fixture value for testing that replaces node bits
@param clock        a fixture value for testing that replaces clock bits
@param baseTimeSpec - a string specification for the base time value

  - *example:* `ToFinestTimeUUID('20171231T1015.243',123,456)`
  - *ms basetime, specified node and clock data*

## ToJodaDateTime

Convert the input value to a {@code org.joda.time.DateTime}

- long -> ToJodaDateTime(int: spacing, int: repeat_count) -> org.joda.time.DateTime

- long -> ToJodaDateTime(String: spacing) -> org.joda.time.DateTime

- long -> ToJodaDateTime() -> org.joda.time.DateTime

## ToMillisAtStartOfDay

Return the epoch milliseconds at the start of the day for the given epoch milliseconds.

- long -> ToMillisAtStartOfDay() -> long
  - *example:* `ToMillisAtStartOfDay()`
  - *return millisecond epoch time of the start of the day of the provided millisecond epoch time, assuming UTC*

- long -> ToMillisAtStartOfDay(String: timezoneId) -> long
  - *example:* `ToMillisAtStartOfDay('America/Chicago')`
  - *return millisecond epoch time of the start of the day of the provided millisecond epoch time, using timezone America/Chicago*

## ToMillisAtStartOfHour

Return the epoch milliseconds at the start of the hour for the given epoch milliseconds.

- long -> ToMillisAtStartOfHour() -> long
  - *example:* `ToMillisAtStartOfHour()`
  - *return millisecond epoch time of the start of the hour of the provided millisecond epoch time, assuming UTC*

- long -> ToMillisAtStartOfHour(String: timezoneId) -> long
  - *example:* `ToMillisAtStartOfHour('America/Chicago')`
  - *return millisecond epoch time of the start of the hour of the provided millisecond epoch time, using timezone America/Chicago*

## ToMillisAtStartOfMinute

Return the epoch milliseconds at the start of the minute for the given epoch milliseconds.

- long -> ToMillisAtStartOfMinute() -> long
  - *example:* `ToMillisAtStartOfMinute()`
  - *return millisecond epoch time of the start of the minute of the provided millisecond epoch time, assuming UTC*

- long -> ToMillisAtStartOfMinute(String: timezoneId) -> long
  - *example:* `ToMillisAtStartOfMinute('America/Chicago')`
  - *return millisecond epoch time of the start of the minute of the provided millisecond epoch time, using timezone America/Chicago*

## ToMillisAtStartOfMonth

Return the epoch milliseconds at the start of the month for the given epoch milliseconds.

- long -> ToMillisAtStartOfMonth() -> long
  - *example:* `ToMillisAtStartOfMonth()`
  - *return millisecond epoch time of the start of the month of the provided millisecond epoch time, assuming UTC*

- long -> ToMillisAtStartOfMonth(String: timezoneId) -> long
  - *example:* `ToMillisAtStartOfMonth('America/Chicago')`
  - *return millisecond epoch time of the start of the month of the provided millisecond epoch time, using timezone America/Chicago*

## ToMillisAtStartOfNamedWeekDay

Return the epoch milliseconds at the start of the most recent day that falls on the given weekday for the given epoch milliseconds, including the current day if valid.

- long -> ToMillisAtStartOfNamedWeekDay() -> long
  - *example:* `ToMillisAtStartOfNamedWeekDay()`
  - *return millisecond epoch time of the start of the most recent Monday (possibly the day-of) of the provided millisecond epoch time, assuming UTC*

- long -> ToMillisAtStartOfNamedWeekDay(String: weekday) -> long
  - *example:* `ToMillisAtStartOfNamedWeekDay('Wednesday')`
  - *return millisecond epoch time of the start of the most recent Wednesday (possibly the day-of) of the provided millisecond epoch time, assuming UTC*

- long -> ToMillisAtStartOfNamedWeekDay(String: weekday, String: timezoneId) -> long
  - *example:* `ToMillisAtStartOfNamedWeekDay('Saturday','America/Chicago'')`
  - *return millisecond epoch time of the start of the most recent Saturday (possibly the day-of) of the provided millisecond epoch time, using timezone America/Chicago*

## ToMillisAtStartOfNextDay

Return the epoch milliseconds at the start of the day after the day for the given epoch milliseconds.

- long -> ToMillisAtStartOfNextDay() -> long
  - *example:* `ToMillisAtStartOfNextDay()`
  - *return millisecond epoch time of the start of next day (not including day-of) of the provided millisecond epoch time, assuming UTC*

- long -> ToMillisAtStartOfNextDay(String: timezoneId) -> long
  - *example:* `ToMillisAtStartOfNextDay('America/Chicago')`
  - *return millisecond epoch time of the start of the next day (not including day-of) of the provided millisecond epoch time, using timezone America/Chicago*

## ToMillisAtStartOfNextNamedWeekDay

Return the epoch milliseconds at the start of the next day that falls on the given weekday for the given epoch milliseconds, not including the current day.

- long -> ToMillisAtStartOfNextNamedWeekDay() -> long
  - *example:* `ToMillisAtStartOfNextNamedWeekDay()`
  - *return millisecond epoch time of the start of the next Monday (not the day-of) of the provided millisecond epoch time, assuming UTC*

- long -> ToMillisAtStartOfNextNamedWeekDay(String: weekday) -> long
  - *example:* `ToMillisAtStartOfNextNamedWeekDay('Wednesday')`
  - *return millisecond epoch time of the start of the next Wednesday (not the day-of) of the provided millisecond epoch time, assuming UTC*

- long -> ToMillisAtStartOfNextNamedWeekDay(String: weekday, String: timezoneId) -> long
  - *example:* `ToMillisAtStartOfNextNamedWeekDay('Saturday','America/Chicago'')`
  - *return millisecond epoch time of the start of the next Saturday (not the day-of) of the provided millisecond epoch time, using timezone America/Chicago*

## ToMillisAtStartOfSecond

Return the epoch milliseconds at the start of the second for the given epoch milliseconds.

- long -> ToMillisAtStartOfSecond() -> long
  - *example:* `ToMillisAtStartOfSecond()`
  - *return millisecond epoch time of the start of the second of the provided millisecond epoch time, assuming UTC*

- long -> ToMillisAtStartOfSecond(String: timezoneId) -> long
  - *example:* `ToMillisAtStartOfSecond('America/Chicago')`
  - *return millisecond epoch time of the start of the second of the provided millisecond epoch time, using timezone America/Chicago*

## ToMillisAtStartOfYear

Return the epoch milliseconds at the start of the year for the given epoch milliseconds.

- long -> ToMillisAtStartOfYear() -> long
  - *example:* `ToMillisAtStartOfYear()`
  - *return millisecond epoch time of the start of the year of the provided millisecond epoch time, assuming UTC*

- long -> ToMillisAtStartOfYear(String: timezoneId) -> long
  - *example:* `ToMillisAtStartOfYear('America/Chicago')`
  - *return millisecond epoch time of the start of the year of the provided millisecond epoch time, using timezone America/Chicago*

## ToTimeUUIDMax

Converts a long timestamp in epoch millis form into a Version 1 TimeUUID according to [RFC 4122](https://www.ietf.org/rfc/rfc4122.txt). This form uses {@link UUIDs#startOf(long)}

- long -> ToTimeUUIDMax() -> UUID

## ToTimeUUIDMin

Converts a long timestamp in epoch millis form into a Version 1 TimeUUID according to [RFC 4122](https://www.ietf.org/rfc/rfc4122.txt). This form uses {@link UUIDs#startOf(long)}

- long -> ToTimeUUIDMin() -> UUID

