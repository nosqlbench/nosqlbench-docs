---
title: "Next Steps"
weight: 5
---

Now that you've run NoSQLBench for the first time and seen what it does, you can choose what level
of customization you want for further testing.

The sections below describe key areas that users typically customize when working with NoSQLBench.

Everyone who uses NoSQLBench will want to get familiar with the
[Core Concepts](/../nosqlbench/core-concepts)
section. This is essential reading for new and experienced testers alike.

## High-Level Users

Several canonical workloads are already baked-in to NoSQLBench for immediate use. If you are simply
wanting to drive workloads without building a custom workload, then you'll want to learn about 
the available workloads and their options.

## Workload Builders

If you want to use NoSQLBench to build a tailored workload that closely emulates what a specific
application would do, then you can build a self-contained and portable YAML file that specifies all 
the details. You can specify the access patterns, data distributions, and more. This is 
explained further in [Workloads 101](/../workloads_101)

### Built-In Sources

You can use the `--list-workloads` option to see all the built-in workloads, and then use the 
`--copy <name>` option to copy them out of the runtime into your local directory.
These sources provide a wealth of examples to consider as you build your own workloads or customize
existing ones.

## Scenario Developers

For advanced scenario designs, iterative testing models, or analysis methods, you can use ECMAScript
to control the scenario from start to finish. This is an advanced feature that is not recommended
for first-time users. If you need this feature and run into any issues, join us on the discord 
server and strike up a conversation!
