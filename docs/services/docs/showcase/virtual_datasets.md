---
title: Virtual Datasets
weight: 1
---

# Virtual Datasets

The _Virtual Dataset_ capabilities within NoSQLBench allow you to generate
data on the fly. There are many reasons for using this technique in
testing, but it is often a topic that is overlooked or taken for granted.

This has multiple positive effects on the fidelity of the test:

1) It is much much more efficient than interacting with storage systems and piping data around. Even loading
   data from lightweight storage like NVMe will be more time intensive than simply generating it in most cases.
2) As such, it leaves significant headroom on the table for introducing other valuable capabilities into
   the test system, like advanced rate metering, coordinated ommission awareness, etc.
3) Changing the data which is generated is as easy as changing the recipe.
4) The efficiency of the client is often high enough to support single-client test setups without appreciable
   loss of capacity.
5) Because of modern procedural generation techniques, the variety and shape of data available is significant.
   Increasing the space of possibilities is a matter of adding new algorithms. There is no data bulk to manage.
6) Sophisticated test setups that are highly data dependent are portable. All you need is the test client.
   The building blocks for data generation are included, and many pre-built testing scenarios are already
   wired to use them.

Additional details of this approach are explained below.

## Industrial Strength

The algorithms used to generate data are based on advanced techniques in
the realm of variate sampling. The authors have gone to great lengths to
ensure that data generation is efficient and as much O(1) in processing
time as possible.

For example...

One technique that is used to achieve this is to initialize and cache data
in high resolution look-up tables for distributions which may otherwise
perform differently depending on their respective density functions. The
existing Apache Commons Math libraries have been adapted into a set of
interpolated Inverse Cumulative Distribution sampling functions. This
means that you can use them all in the same place as you would a Uniform
distribution, and once initialized, they sample with identical overhead.
This means that by changing your test definition, you don't accidentally
change the behavior of your test client, only the data as intended.

## A Purpose-Built Tool

Many other testing systems avoid building a dataset generation component.
It's a tough problem to solve, so it's often just avoided. Instead, they
use libraries like "faker" or other sources of data which weren't designed
for testing at scale. Faker is well named, no pun intended. It was meant
as a vignette and wire-framing library, not a source of test data for
realistic results. If you are using a testing tool for scale testing and
relying on a faker variant, then you will almost certainly get invalid
results that do not represent how a system would perform in production.

The virtual dataset component of NoSQLBench is a library that was designed
for high scale and realistic data streams. It uses the limits of the data
types in the JVM to simulate high cardinality datasets which approximate
production data distributions for realistic and reproducible results.

## Deterministic

The data that is generated by the virtual dataset libraries is
deterministic. This means that for a given cycle in a test, the operation
that is synthesized for that cycle will be the same from one session to
the next. This is intentional. If you want to perturb the test data from
one session to the next, then you can most easily do it by simply
selecting a different set of cycles as your basis.

This means that if you find something interesting in a test run, you can
go back to it just by specifying the cycles in question. It also means
that you aren't losing comparative value between tests with additional
randomness thrown in. The data you generate will still look random to the
human eye, but that doesn't mean that it can't be reproducible.

## Statistically Shaped

All this means is that the values you use to tie your dataset together can
be specific to any distribution that is appropriate. You can ask for a
stream of floating point values 1 trillion values long, in any order. You
can use discrete or continuous distributions, with whatever distribution
parameters you need.

## Best of Both Worlds

Some might worry that fully synthetic testing data is not realistic
enough. The devil is in the details on these arguments, but suffice it to
say that you can pick the level of real data you use as seed data with
NoSQLBench. You don't have to choose between realism and agility. The
procedural data generation approach allows you to have all the benefits of
testing agility of low-entropy testing tools while retaining nearly all of
the benefits of real testing data.

For example, using the alias sampling method and a published US census
(public domain) list of names and surnames tha occurred more than 100x, we
can provide extremely accurate samples of names according to the published
labels and weights. The alias method allows us to sample accurately in
O(1) time from the entire dataset by turning a large number of weights
into two uniform samples. You will simply not find a better way to sample
realistic (US) names than this. (If you do, please file an issue!)
Actually, any data set that you have in CSV form with a weight column can
also be used this way, so you're not strictly limited to US census data.

## Java Idiomatic Extension

The way that the virtual dataset component works allows Java developers to
write any extension to the data generation functions simply in the form of
Java 8 or newer Functional interfaces. As long as they include the
annotation processor and annotate their classes, they will show up in the
runtime and be available to any workload by their class name.

Additionally, annotation based examples and annotation processing is used
to hoist function docs directly into the published docs that go along with
any version of NoSQLBench.

## Binding Recipes

It is possible to stitch data generation functions together directly in a
workload YAML. These are data-flow sketches of functions that can be
copied and pasted between workload descriptions to share or remix data
streams. This allows for the adventurous to build sophisticated virtual
datasets that emulate nuances of real datasets, but in a form that takes
up less space on the screen than this paragraph!