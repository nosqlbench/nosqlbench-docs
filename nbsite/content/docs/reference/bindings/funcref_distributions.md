---
title: distribution functions
weight: 30
---

All of the distributions that are provided in the Apache Commons Math
project are supported here, in multiple forms.

## Continuous or Discrete

These distributions break down into two main categories:

### Continuous Distributions

These are distributions over real numbers like 23.4323, with continuity across the values. Each of the continuous
distributions can provide samples that fall on an interval of the real number line. Continuous probability distributions
include the *Normal* distribution, and the *Exponential* distribution, among many others.

### Discrete Distributions

Discrete distributions, also known as *integer distributions* have only whole-number valued samples. These distributions
include the *Binomial* distribution, the *Zipf* distribution, and the *Poisson* distribution, among others.

## Hashed or Mapped

### hashed samples

Generally, you will want to "randomly sample" from a probability distribution. This is handled automatically by the
functions below if you do not override the defaults. **The `hash` mode is the default sampling mode for probability
distributions.** This is accomplished by hashing the input before using the resulting value with the sampling curve.
This is called the `hash` sampling mode by VirtData. You can put `hash` into the modifiers as explained below if you
want to document it explicitly.

### mapped samples

The method used to sample from these distributions depends on a mathematical function called the cumulative probability
density function, or more specifically the inverse of it. Having this function computed over some interval allows one to
sample the shape of a distribution progressively if desired. In other words, it allows for some *percentile-like* view
of values within a given probability distribution. This mode of using the inverse cumulative density function is known
as the `map` mode in VirtData, as it allows one to map a unit interval variate in a deterministic way to a density
sampling curve. To enable this mode, simply pass `map` as one of the function modifiers for any function in this
category.

## Interpolated or Computed Samples

When sampling from mathematical models of probability densities,
performance between different densities can vary drastically. This means
that you may end up perturbing the results of your test in an unexpected
way simply by changing parameters of your testing distributions. Even
worse, some densities have painful corner cases in performance, like
'Zipf', which can make tests unbearably slow and flawed as they chew up
CPU resources.

**NOTE:**
Functions like 'Zipf' can still take a long time to initialize for certain
parameters. If you are seeing a workload that seems to hang while
initializing, it might be computing complex integrals for large parameters
of Zipf. We hope to pre-compute and cache these at a future time to avoid
this type of impact. For now, just be aware that some parameters on some
density curves can be expensive to compute _even during initialization_.

### Interpolated Samples

For this reason, interpolation is built-in to these sampling functions. **The default mode is `interpolate`.** This
means that the sampling function is pre-computed over 1000 equidistant points in the unit interval (0.0,1.0), and the
result is shared among all threads as a look-up-table for interpolation. This makes all statistical sampling functions
perform nearly identically at runtime (after initialization, a one time cost). This does have the minor side effect of a
little loss in accuracy, but the difference is generally negligible for nearly all performance testing cases.

#### Infinite or Finite

For interpolated samples from continuous distributions, you also have the option of including or
excluding infinite values which may occur in some distributions. If you want to include them,
use `infinite`, or `finite` to explicitly avoid them (the default). Specifying 'infinite'
doesn't guarantee that you will see +Infinity or -Infinity, only that they are allowed. The
Normal distribution often contains -Infinity and +Infinity, for example, due to the function
used to estimate its cumulative distribution. These values can often be valuable in finding
corner cases which should be treated uniformly according to
[IEEE 754](https://en.wikipedia.org/wiki/IEEE_754).

#### Clamp or Noclamp

For interpolated samples from continuous distributions, you also have the option of clamping the
allowed values to the valid range for the integral data type used as input. To clamp the output
values to the range (Long.MIN_VALUE,Long.MAX_VALUE) for long->double functions, or to (Integer.
MIN_VALUE,Integer.MAX_VALUE) for int-double functions, specify `clamp`, which is also the default.
To explicitly disable this, use `noclamp`. This is useful when you know the downstream functions
will only work with a certain range of values without truncating conversions. When you are using
double values natively on the downstream functions, use `noclamp` to avoid limiting the domain of
values in your test data. (In this case, you might also consider `infinite`).

### Computed Samples

Conversely, `compute` mode sampling calls the sampling function every time a sample is needed. This affords a little
more accuracy, but is generally *not* preferable to the default interpolated mode. You'll know if you need computed
samples. Otherwise, it's best to stick with interpolation so that you spend more time testing your target system and
less time testing your data generation functions.

## Input Range

All of these functions take a long as the input value for sampling. This is similar to how the unit interval (0.0,1.0)
is used in mathematics and statistics, but more tailored to modern system capabilities. Instead of using the unit
interval, we simply use the interval of all positive longs. This provides more compatibility with other functions in
VirtData, including hashing functions. Internally, this value is automatically converted to a unit interval variate as
needed to work well with the distributions from Apache Math.


## Beta

@see [Wikipedia: Beta distribution](https://en.wikipedia.org/wiki/Beta_distribution) @see [Commons JavaDoc: BetaDistribution](https://commons.apache.org/proper/commons-statistics/commons-statistics-distribution/apidocs/org/apache/commons/statistics/distribution/BetaDistribution.html)

- long -> Beta(double: alpha, double: beta, String[]...: mods) -> double

- int -> Beta(double: alpha, double: beta, String[]...: mods) -> double

## Binomial

@see [Wikipedia: Binomial distribution](http://en.wikipedia.org/wiki/Binomial_distribution) @see [Commons JavaDoc: BinomialDistribution](https://commons.apache.org/proper/commons-statistics/commons-statistics-distribution/apidocs/org/apache/commons/statistics/distribution/BinomialDistribution.html)

- int -> Binomial(int: trials, double: p, String[]...: modslist) -> int

- long -> Binomial(int: trials, double: p, String[]...: modslist) -> long

- int -> Binomial(int: trials, double: p, String[]...: modslist) -> long

- long -> Binomial(int: trials, double: p, String[]...: modslist) -> int

## Cauchy

@see [Wikipedia: Cauchy_distribution](http://en.wikipedia.org/wiki/Cauchy_distribution) @see [Commons Javadoc: CauchyDistribution](https://commons.apache.org/proper/commons-statistics/commons-statistics-distribution/apidocs/org/apache/commons/statistics/distribution/CauchyDistribution.html)

- long -> Cauchy(double: median, double: scale, String[]...: mods) -> double

- int -> Cauchy(double: median, double: scale, String[]...: mods) -> double

## ChiSquared

@see [Wikipedia: Chi-squared distribution](https://en.wikipedia.org/wiki/Chi-squared_distribution) @see [Commons JavaDoc: ChiSquaredDistribution](https://commons.apache.org/proper/commons-statistics/commons-statistics-distribution/apidocs/org/apache/commons/statistics/distribution/ChiSquaredDistribution.html)

- long -> ChiSquared(double: degreesOfFreedom, String[]...: mods) -> double

- int -> ChiSquared(double: degreesOfFreedom, String[]...: mods) -> double

## CoinFunc

This is a higher-order function which takes an input value, and flips a coin. The first parameter is used as the threshold for choosing a function. If the sample values derived from the input is lower than the threshold value, then the first following function is used, and otherwise the second is used. For example, if the threshold is 0.23, and the input value is hashed and sampled in the unit interval to 0.43, then the second of the two provided functions will be used. The input value does not need to be hashed beforehand, since the user may need to use the full input value before hashing as the input to one or both of the functions. This function will accept either a LongFunction or a {@link Function} or a LongUnaryOperator in either position. If necessary, use {@link function.ToLongFunction} to adapt other function forms to be compatible with these signatures.

- Long -> CoinFunc(double: threshold, Object: first, Object: second) -> Object
  - *example:* `CoinFunc(0.15,NumberNameToString(),Combinations('A:1:B:23'))`
  - *use the first function 15% of the time*

## ConstantContinuous

Always yields the same value. @see [Commons JavaDoc: ConstantContinuousDistribution](https://commons.apache.org/proper/commons-statistics/commons-statistics-distribution/apidocs/org/apache/commons/statistics/distribution/ConstantContinuousDistribution.html)

- long -> ConstantContinuous(double: value, String[]...: mods) -> double

- int -> ConstantContinuous(double: value, String[]...: mods) -> double

## Enumerated

Creates a probability density given the values and optional weights provided, in "value:weight value:weight ..." form. The weight can be elided for any value to use the default weight of 1.0d. @see [Commons JavaDoc: EnumeratedRealDistribution](http://commons.apache.org/proper/commons-math/apidocs/org/apache/commons/math4/distribution/EnumeratedRealDistribution.html)

- int -> Enumerated(String: data, String[]...: mods) -> double
  - *example:* `Enumerated('1 2 3 4 5 6')`
  - *a fair six-sided die roll*
  - *example:* `Enumerated('1:2.0 2 3 4 5 6')`
  - *an unfair six-sided die roll, where 1 has probability mass 2.0, and everything else has only 1.0*

- long -> Enumerated(String: data, String[]...: mods) -> double
  - *example:* `Enumerated('1 2 3 4 5 6')`
  - *a fair 6-sided die*
  - *example:* `Enumerated('1:2.0 2 3 4 5:0.5 6:0.5')`
  - *an unfair fair 6-sided die, where ones are twice as likely, and fives and sixes are half as likely*

## Exponential

@see [Wikipedia: Exponential distribution](https://en.wikipedia.org/wiki/Exponential_distribution) @see [Commons JavaDoc: ExponentialDistribution](https://commons.apache.org/proper/commons-statistics/commons-statistics-distribution/apidocs/org/apache/commons/statistics/distribution/ExponentialDistribution.html)

- long -> Exponential(double: mean, String[]...: mods) -> double

- int -> Exponential(double: mean, String[]...: mods) -> double

## F

@see [Wikipedia: F-distribution](https://en.wikipedia.org/wiki/F-distribution) @see [Commons JavaDoc: FDistribution](https://commons.apache.org/proper/commons-statistics/commons-statistics-distribution/apidocs/org/apache/commons/statistics/distribution/FDistribution.html) @see [Mathworld: F-Distribution](http://mathworld.wolfram.com/F-Distribution.html)

- int -> F(double: numeratorDegreesOfFreedom, double: denominatorDegreesOfFreedom, String[]...: mods) -> double

- long -> F(double: numeratorDegreesOfFreedom, double: denominatorDegreesOfFreedom, String[]...: mods) -> double

## Gamma

@see [Wikipedia: Gamma distribution](https://en.wikipedia.org/wiki/Gamma_distribution) @see [Commons JavaDoc: GammaDistribution](https://commons.apache.org/proper/commons-statistics/commons-statistics-distribution/apidocs/org/apache/commons/statistics/distribution/GammaDistribution.html)

- long -> Gamma(double: shape, double: scale, String[]...: mods) -> double

- int -> Gamma(double: shape, double: scale, String[]...: mods) -> double

## Geometric

@see [Wikipedia: Geometric distribution](http://en.wikipedia.org/wiki/Geometric_distribution) @see [Commons JavaDoc: GeometricDistribution](https://commons.apache.org/proper/commons-statistics/commons-statistics-distribution/apidocs/org/apache/commons/statistics/distribution/GeometricDistribution.html)

- int -> Geometric(double: p, String[]...: modslist) -> int

- long -> Geometric(double: p, String[]...: modslist) -> long

- int -> Geometric(double: p, String[]...: modslist) -> long

- long -> Geometric(double: p, String[]...: modslist) -> int

## Gumbel

@see [Wikipedia: Gumbel distribution](https://en.wikipedia.org/wiki/Gumbel_distribution) @see [Commons JavaDoc: GumbelDistribution](https://commons.apache.org/proper/commons-statistics/commons-statistics-distribution/apidocs/org/apache/commons/statistics/distribution/GumbelDistribution.html)

- long -> Gumbel(double: mu, double: beta, String[]...: mods) -> double

- int -> Gumbel(double: mu, double: beta, String[]...: mods) -> double

## Hypergeometric

@see [Wikipedia: Hypergeometric distribution](http://en.wikipedia.org/wiki/Hypergeometric_distribution) @see [Commons JavaDoc: HypergeometricDistribution](https://commons.apache.org/proper/commons-statistics/commons-statistics-distribution/apidocs/org/apache/commons/statistics/distribution/HypergeometricDistribution.html)

- int -> Hypergeometric(int: populationSize, int: numberOfSuccesses, int: sampleSize, String[]...: modslist) -> int

- int -> Hypergeometric(int: populationSize, int: numberOfSuccesses, int: sampleSize, String[]...: modslist) -> long

- long -> Hypergeometric(int: populationSize, int: numberOfSuccesses, int: sampleSize, String[]...: modslist) -> long

- long -> Hypergeometric(int: populationSize, int: numberOfSuccesses, int: sampleSize, String[]...: modslist) -> int

## Laplace

@see [Wikipedia: Laplace distribution](https://en.wikipedia.org/wiki/Laplace_distribution) @see [Commons JavaDoc: LaplaceDistribution](https://commons.apache.org/proper/commons-statistics/commons-statistics-distribution/apidocs/org/apache/commons/statistics/distribution/LaplaceDistribution.html)

- long -> Laplace(double: mu, double: beta, String[]...: mods) -> double

- int -> Laplace(double: mu, double: beta, String[]...: mods) -> double

## Levy

@see [Wikipedia: Lévy distribution](https://en.wikipedia.org/wiki/L%C3%A9vy_distribution) @see [Commons JavaDoc: LevyDistribution](https://commons.apache.org/proper/commons-statistics/commons-statistics-distribution/apidocs/org/apache/commons/statistics/distribution/LevyDistribution.html)

- int -> Levy(double: mu, double: c, String[]...: mods) -> double

- long -> Levy(double: mu, double: c, String[]...: mods) -> double

## LogNormal

@see [Wikipedia: Log-normal distribution](https://en.wikipedia.org/wiki/Log-normal_distribution) @see [Commons JavaDoc: LogNormalDistribution](https://commons.apache.org/proper/commons-statistics/commons-statistics-distribution/apidocs/org/apache/commons/statistics/distribution/LogNormalDistribution.html)

- long -> LogNormal(double: scale, double: shape, String[]...: mods) -> double

- int -> LogNormal(double: scale, double: shape, String[]...: mods) -> double

## Logistic

@see [Wikipedia: Logistic distribution](https://en.wikipedia.org/wiki/Logistic_distribution) @see [Commons JavaDoc: LogisticDistribution](https://commons.apache.org/proper/commons-statistics/commons-statistics-distribution/apidocs/org/apache/commons/statistics/distribution/LogisticDistribution.html)

- int -> Logistic(double: mu, double: scale, String[]...: mods) -> double

- long -> Logistic(double: mu, double: scale, String[]...: mods) -> double

## Nakagami

@see [Wikipedia: Nakagami distribution](https://en.wikipedia.org/wiki/Nakagami_distribution) @see [Commons JavaDoc: NakagamiDistribution](https://commons.apache.org/proper/commons-statistics/commons-statistics-distribution/apidocs/org/apache/commons/statistics/distribution/NakagamiDistribution.html)

- long -> Nakagami(double: mu, double: omega, String[]...: mods) -> double

- int -> Nakagami(double: mu, double: omega, String[]...: mods) -> double

## Normal

@see [Wikipedia: Normal distribution](https://en.wikipedia.org/wiki/Normal_distribution) @see [Commons JavaDoc: NormalDistribution](https://commons.apache.org/proper/commons-statistics/commons-statistics-distribution/apidocs/org/apache/commons/statistics/distribution/NormalDistribution.html)

- long -> Normal(double: mean, double: sd, String[]...: mods) -> double

- int -> Normal(double: mean, double: sd, String[]...: mods) -> double

## Pareto

@see [Wikipedia: Pareto distribution](https://en.wikipedia.org/wiki/Pareto_distribution) @see [Commons JavaDoc: ParetoDistribution](https://commons.apache.org/proper/commons-statistics/commons-statistics-distribution/apidocs/org/apache/commons/statistics/distribution/ParetoDistribution.html)

- int -> Pareto(double: scale, double: shape, String[]...: mods) -> double

- long -> Pareto(double: scale, double: shape, String[]...: mods) -> double

## Pascal

@see [Commons JavaDoc: PascalDistribution](https://commons.apache.org/proper/commons-statistics/commons-statistics-distribution/apidocs/org/apache/commons/statistics/distribution/PascalDistribution.html) @see [Wikipedia: Negative binomial distribution](https://en.wikipedia.org/wiki/Negative_binomial_distribution)

- long -> Pascal(int: r, double: p, String[]...: modslist) -> int

- int -> Pascal(int: r, double: p, String[]...: modslist) -> long

- long -> Pascal(int: r, double: p, String[]...: modslist) -> long

- int -> Pascal(int: r, double: p, String[]...: modslist) -> int

## Poisson

@see [Wikipedia: Poisson distribution](http://en.wikipedia.org/wiki/Poisson_distribution) @see [Commons JavaDoc: PoissonDistribution](https://commons.apache.org/proper/commons-statistics/commons-statistics-distribution/apidocs/org/apache/commons/statistics/distribution/PoissonDistribution.html)

- long -> Poisson(double: p, String[]...: modslist) -> long

- int -> Poisson(double: p, String[]...: modslist) -> long

- int -> Poisson(double: p, String[]...: modslist) -> int

- long -> Poisson(double: p, String[]...: modslist) -> int

## T

@see [Wikipedia: Student's t-distribution](https://en.wikipedia.org/wiki/Student's_t-distribution) @see [Commons JavaDoc: TDistribution](https://commons.apache.org/proper/commons-statistics/commons-statistics-distribution/apidocs/org/apache/commons/statistics/distribution/TDistribution.html)

- int -> T(double: degreesOfFreedom, String[]...: mods) -> double

- long -> T(double: degreesOfFreedom, String[]...: mods) -> double

## Triangular

@see [Wikipedia: Triangular distribution](https://en.wikipedia.org/wiki/Triangular_distribution) @see [Commons JavaDoc: TriangularDistribution](https://commons.apache.org/proper/commons-statistics/commons-statistics-distribution/apidocs/org/apache/commons/statistics/distribution/TriangularDistribution.html)

- long -> Triangular(double: a, double: c, double: b, String[]...: mods) -> double

- int -> Triangular(double: a, double: c, double: b, String[]...: mods) -> double

## Uniform

@see [Wikipedia: Uniform distribution (continuous)](https://en.wikipedia.org/wiki/Uniform_distribution_(continuous)) @see [Commons JavaDoc: UniformContinuousDistribution](https://commons.apache.org/proper/commons-statistics/commons-statistics-distribution/apidocs/org/apache/commons/statistics/distribution/UniformContinuousDistribution.html)

- int -> Uniform(double: lower, double: upper, String[]...: mods) -> double

- long -> Uniform(int: lower, int: upper, String[]...: modslist) -> int

- int -> Uniform(int: lower, int: upper, String[]...: modslist) -> int

- int -> Uniform(int: lower, int: upper, String[]...: modslist) -> long

- long -> Uniform(int: lower, int: upper, String[]...: modslist) -> long

- long -> Uniform(double: lower, double: upper, String[]...: mods) -> double

## Weibull

@see [Wikipedia: Weibull distribution](https://en.wikipedia.org/wiki/Weibull_distribution) @see [Wolfram Mathworld: Weibull Distribution](http://mathworld.wolfram.com/WeibullDistribution.html) @see [Commons Javadoc: WeibullDistribution](https://commons.apache.org/proper/commons-statistics/commons-statistics-distribution/apidocs/org/apache/commons/statistics/distribution/WeibullDistribution.html)

- int -> Weibull(double: alpha, double: beta, String[]...: mods) -> double

- long -> Weibull(double: alpha, double: beta, String[]...: mods) -> double

## WeightedFuncs

Allows for easy branching over multiple functions with specific weights.

- long -> WeightedFuncs(Object[]...: weightsAndFuncs) -> Object

## Zipf

@see [Wikipedia: Zipf's Law](https://en.wikipedia.org/wiki/Zipf's_law) @see [Commons JavaDoc: ZipfDistribution](https://commons.apache.org/proper/commons-statistics/commons-statistics-distribution/apidocs/org/apache/commons/statistics/distribution/ZipfDistribution.html)

- long -> Zipf(int: numberOfElements, double: exponent, String[]...: modslist) -> long

- int -> Zipf(int: numberOfElements, double: exponent, String[]...: modslist) -> long

- long -> Zipf(int: numberOfElements, double: exponent, String[]...: modslist) -> int

- int -> Zipf(int: numberOfElements, double: exponent, String[]...: modslist) -> int

