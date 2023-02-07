---
title: Distance
weight: 154805211
---
## Distance

Create a Distance generator which produces com.datastax.driver.dse.geometry.Distance objects.

- long -> Distance(function.LongToDoubleFunction: xfunc, function.LongToDoubleFunction: yfunc, function.LongToDoubleFunction: rfunc) -> com.datastax.dse.driver.internal.core.data.geometry.Distance

- long -> Distance(double: x, function.LongToDoubleFunction: yfunc, function.LongToDoubleFunction: rfunc) -> com.datastax.dse.driver.internal.core.data.geometry.Distance

- long -> Distance(function.LongToDoubleFunction: xfunc, double: y, function.LongToDoubleFunction: rfunc) -> com.datastax.dse.driver.internal.core.data.geometry.Distance

- long -> Distance(double: x, double: y, function.LongToDoubleFunction: rfunc) -> com.datastax.dse.driver.internal.core.data.geometry.Distance

- long -> Distance(function.LongToDoubleFunction: xfunc, function.LongToDoubleFunction: yfunc, double: r) -> com.datastax.dse.driver.internal.core.data.geometry.Distance

- long -> Distance(double: x, function.LongToDoubleFunction: yfunc, double: r) -> com.datastax.dse.driver.internal.core.data.geometry.Distance

- long -> Distance(function.LongToDoubleFunction: xfunc, double: y, double: r) -> com.datastax.dse.driver.internal.core.data.geometry.Distance

- long -> Distance(double: x, double: y, double: r) -> com.datastax.dse.driver.internal.core.data.geometry.Distance

## LineString

Create a com.datastax.driver.dse.geometry.LineString

- long -> LineString(function.LongToIntFunction: lenfunc, function.LongFunction<com.datastax.dse.driver.api.core.data.geometry.Point>: pointfunc) -> com.datastax.dse.driver.api.core.data.geometry.LineString

- long -> LineString(function.LongToIntFunction: lenfunc, function.LongToDoubleFunction: xfunc, function.LongToDoubleFunction: yfunc) -> com.datastax.dse.driver.api.core.data.geometry.LineString

- long -> LineString(int: len, function.LongFunction<com.datastax.dse.driver.api.core.data.geometry.Point>: pointfunc) -> com.datastax.dse.driver.api.core.data.geometry.LineString

## Point

Create a Point generator which generates com.datastax.driver.dse.geometry.Point objects.

- long -> Point(double: x, double: y) -> com.datastax.dse.driver.api.core.data.geometry.Point

- long -> Point(double: x, function.LongToDoubleFunction: yfunc) -> com.datastax.dse.driver.api.core.data.geometry.Point

- long -> Point(function.LongToDoubleFunction: xfunc, double: y) -> com.datastax.dse.driver.api.core.data.geometry.Point

- long -> Point(function.LongToDoubleFunction: xfunc, function.LongToDoubleFunction: yfunc) -> com.datastax.dse.driver.api.core.data.geometry.Point

## Polygon

Create a com.datastax.driver.dse.geometry.Polygon

- long -> Polygon(function.LongToIntFunction: lenfunc, function.LongFunction<com.datastax.dse.driver.api.core.data.geometry.Point>: pointfunc) -> com.datastax.dse.driver.api.core.data.geometry.Polygon

- long -> Polygon(function.LongToIntFunction: lenfunc, function.LongToDoubleFunction: xfunc, function.LongToDoubleFunction: yfunc) -> com.datastax.dse.driver.api.core.data.geometry.Polygon

- long -> Polygon(int: len, function.LongFunction<com.datastax.dse.driver.api.core.data.geometry.Point>: pointfunc) -> com.datastax.dse.driver.api.core.data.geometry.Polygon

## PolygonOnGrid

This function will return a polygon in the form of a rectangle from the specified grid system. The coordinates define the top left and bottom right coordinates in (x1,y1),(x2,y2) order, while the number of rows and columns divides these ranges into the unit-length for each square. x1 must be greater than x2. y1 must be less than y2. This grid system can be used to construct a set of overlapping grids such that the likelyhood of overlap is somewhat easy to reason about. For example, if you create one grid system as a refernce grid, then attempt to map another grid system which half overlaps the original grid, you can easily determine that half the time, a random rectangle selected from the second grid will overlap a rectangle from the first, for simple even-numbered grids and the expected uniform sampling on the internal coordinate selector functions.

- long -> PolygonOnGrid(double: x_topleft, double: y_topleft, double: x_bottomright, double: y_bottomright, int: rows, int: columns) -> com.datastax.dse.driver.api.core.data.geometry.Polygon
  - *example:* `PolygonOnGrid(1, 11, 11, 1, 10, 10)`
  - *Create a 10x10 grid with cells 1x1, spaced one off the y=0 and x=0 axes*

