---
title: "Core Concepts"
weight: 2
---

NoSQLBench is built on top of core concepts that have been scrutinized, replaced, refined, and
hardened through several years of use by a diverse set of users.

This level of refinement is important when trying to find a way to express common patterns in what
is often a highly fragmented practice. Testing is hard. Scale testing is hard. Distributed testing
is hard. Combined, the challenge of executing realistic tests is often quite daunting to all but
seasoned test engineers. To make this worse, existing tools have only skirmished with this problem
enough to make dents, but none has tackled full-on the lack of conceptual building blocks.

This has to change. We need a set of testing concepts that can span across workloads and system
types, and machinery to put these concepts to use. This is why it is important to focus on finding a
useful and robust set of concepts to use as the foundation for the rest of the toolkit to be built
on. Finding these building blocks is often one of the most difficult challenges in systems design.
Once you find and validate a useful set of concepts, everything else gets easier.

We feel that the success that we've already had using NoSQLBench has been strongly tied to the core
concepts. Some concepts used in NoSQLBench are shared below for illustration, but this is by no
means an exhaustive list.

### The Cycle

Cycles in NoSQLBench are whole numbers on a number line. Each operation in a NoSQLBench scenario is
derived from a single cycle. It's a long value, and a seed. The cycle determines not only which
operation is selected for execution, but also what data will be attached to it.

Cycles are specified as a _closed-open_ `[min,max)` interval, just as slices in some languages. That
is, the min value is included in the range, but the max value is not. This means that you can stack
slices using common numeric reference points without overlaps or gaps. It means you can have exact
awareness of what data is in your dataset, even incrementally.

You can think of a cycle as a single-valued coordinate system for data that lives adjacent to that
number on the number line. In this way, virtual dataset functions are ways of converting coordinates
into data.

In NoSQLBench, the cycle range determines both the total size of a workload and the specific set of
operations which will be performed. Using the same cycle range is the same as specifying the same
exact operations. This means that your tests can be completely deterministic (pseudo-random) and
repeatable even when they appear random or are shaped by density curves.

### The Activity

An activity is a multi-threaded flywheel of statements in some sequence and ratio. Each activity
runs over the numbers in a cycle range. An activity is specified as a series of op templates in some
ratio and order. When an activity runs, it executes an efficient loop over specific operations with
its own thread pool.

### The Op Template

Each possible operation in an activity is provided by the user in a YAML or data structure driven
template. The op templates are used to create efficient op dispensers in the runtime according to
the mapping rules for a given driver.

### The Driver Adapter

A driver adapter is a high level driver for a protocol which interfaces a native driver to the
runtime machinery of NoSQLBench. It is like a statement-aware cartridge that knows how to take a
basic op template and turn it into an operation for an activity to execute for a given cycle.

### The Scenario

The scenario is a runtime session that holds activities while they run. A NoSQLBench scenario is
responsible for aggregating global runtime settings, metrics reporting channels, log files, and so
on. All activities run within a scenario, under the control of the scenario script.

### The Scenario Script

Each scenario is governed by a script that runs single-threaded, asynchronously from activities, but
in control of activities. If needed, the scenario script is automatically created for the user, and
the user never knows it is there. If the user has advanced testing requirements, then they may take
advantage of the scripting capability at such time. When the script exits, *AND* all activities are
complete, then the scenario is complete. Shortcut forms of scripting are provided on the command
line to address common variations.
