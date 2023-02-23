---
title: "02 Scenarios"
weight: 102
---

# Scenarios

👉 The commands in this section are examples to show you how the command line works with nb5.

## run a scenario

To run a simple built-in scenario run one of these:

```
./nb5 cql-keyvalue host=<addr> localdc=<localdcname>
```

To run the same scenario against Astra, add the credentials and secure connect bundle:

```shell
./nb5 cql-keyvalue scb=<scb.zip> userfile=<file-with-client-id> passfile=<file-with-client-secret> ...
```

👉 Regardless of what form you are using for the tutorial, you'll want to keep these options 
handy. You may want to drop them in anywhere you see a `...` below. 

This example shows how you can call on a completely pre-built workload template by simply using it 
as the first argument. `cql-keyvalue` is actually a workload description hosted within the binary 
(or jar), at `activities/cql-keyvalue.yaml`. You do have to provide some endpoint and authentication 
details, but these should *not* be added to the workload template anyway.

This also captures some workflow for us. It takes care of:

1. Initializing your schema.
2. Loading background data to provide a realistic scenario. 
3. Running a main activity against the background data.

How this works is explained in more depth throughout this guide. For now, just know that all of 
these details are completely open for you to change simply by modifying the workload template.

## discover Scenarios

To get a list of built-in scenarios run:

    ./nb5 --list-scenarios

If you want a simple list of _workload templates_ which contain _named scenarios_, run:

    ./nb5 --list-workloads

These are distinct commands, because you can have multiple named scenarios in a given workload
template. The commands above scan for all known sources (bundled within or locally on your
filesystem) and provide a list of available scenarios or their containing workload templates.
The example works above when we specify the workload, because it has a default scenario built in.

👉 These commands will include workloads that were shipped with nb5 and workloads in your local
directory. To learn more about how to design custom workloads see
[[Workloads 101](/../workloads-101)].

You can also include the example path prefix which will show many more:

    ./nb5 --list-workloads --include examples

When learning about bindings, it is recommended for first time users to use the above command to 
find lots of examples for inspiration.

## compose scenarios

We could easily ask nb5 to run a different named scenario of our choosing by running this:

    # Run a specific named scenario
    ./nb5 cql-keyvalue astra ...

    # Run a specific step of a specific named scenario
    ./nb5 cql-keyvalue astra.schema ...

    # Run a series of specific steps from specific named scenarios
    ./nb5 cql-keyvalue astra.schema astra.rampup ...

If you don't specify which steps to run, they are all run serially, in the order they are defined.
If you don't specify which named scenario to run, `default` is used.

# Example Activities 

The first examples above show you how to call whole scenarios, which contain multiple steps and 
pre-configured defaults. You can also skip using named scenarios and invoke the activities that 
they invoke directly.

> You can skip the next part of this page if you want to just use built-in scenarios. If you 
> want to know how to drill down to the steps and test them individually, continue on. 

## create a schema

We will start by creating a simple schema in the database: 

```sql
# ( We'll use SQL highlighting for our CQL )
    
CREATE KEYSPACE baselines
 WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '1'}
 AND durable_writes = true;

CREATE TABLE baselines.keyvalue (
    key text PRIMARY KEY,
    value text
)
```

From your command line, go ahead and execute the following command, replacing
the `...` with that of one of your database nodes. Alternately, if using Astra, 
use the options described in the [test target](@/getting-started/01-test-target.md) section.

```
./nb5 run driver=cqld4 workload=cql-keyvalue tags=block:schema ...
```

This follows the basic command pattern of all nb5 commands. The first bare word is a command, 
and all assignments after it are parameters to that command. The `run` command is short for "run 
an activity".

Let's break down each of those command line options.

`run` tells NoSQLBench to run an activity.

`driver=...` is used to specify the activity type (driver). In this case
we are using `cqld4`, which tells NoSQLBench to use the DataStax Java Driver
and execute CQL statements against a database.

`workload=...` is used to specify the workload definition file that defines the activity. In 
this example, we use `cql-keyvalue` which is a pre-built workload that is packaged with 
NoSQLBench.

`tags=block:schema` tells NoSQLBench to run the op templates from a block that is
tagged with `block:schema`. In this example, that is the DDL portion of the `cql-keyvalue` 
workload.

`...` should be the endpoint and authentication details that you used from the first example.

If you like, you can verify the result of this command by describing your
keyspace in cqlsh or DataStax Studio with
`DESCRIBE KEYSPACE baselines`.

## load some data

Before running a test of typical access patterns where you want to capture the results, you 
need to make the test more interesting than loading an empty table. For this, we use the 
rampup activity.

Before sending our test writes to the database, we will use the `stdout` driver, so we can see 
 what NoSQLBench is generating for CQL statements.

Go ahead and execute the following command:

    ./nb5 run driver=stdout workload=cql-keyvalue

You should see 10 of the following statements in your console

```sql
insert into baselines.keyvalue (key, value) values (0,382062539);
insert into baselines.keyvalue (key, value) values (1,774912474);
insert into baselines.keyvalue (key, value) values (2,949364593);
insert into baselines.keyvalue (key, value) values (3,352527683);
insert into baselines.keyvalue (key, value) values (4,351686621);
insert into baselines.keyvalue (key, value) values (5,114304900);
insert into baselines.keyvalue (key, value) values (6,439790106);
insert into baselines.keyvalue (key, value) values (7,564330072);
insert into baselines.keyvalue (key, value) values (8,296173906);
insert into baselines.keyvalue (key, value) values (9,97405552);
```

NoSQLBench deterministically generates data, so the generated values will be the same from run to run.

Now we are ready to write some data to our database. Go ahead and execute the following from your command line:

```shell
./nb5 run driver=cql workload=cql-keyvalue tags=block:rampup cycles=100k ... --progress console:1s
```

Note the differences between this and the command that we used to generate the schema.

`tags=block:rampup` is running the yaml block in `cql-keyvalue` that has only INSERT statements.

`cycles=100k` will run a total of 100,000 operations, in this case,
100,000 writes. You will want to pick an appropriately large number of
cycles in actual testing to make your main test meaningful.

👉 The cycles parameter is not just a quantity. It is a range of values.
The `cycles=n` format is short for
`cycles=0..n`, which makes cycles a zero-based range. For example,
cycles=5 means that the activity will use cycles 0,1,2,3,4, but not 5. The
reason for this is explained in detail in the Activity Parameters section.

These parameters are explained in detail in the section on _Activity
Parameters_.

`--progress console:1s` will print the progression of the run to the
console every 1 second.

You should see output that looks like this

```
cql-keyvalue-astra (remaining,active,completed)=(99377,50,623) 001%
cql-keyvalue-astra (remaining,active,completed)=(98219,50,1782) 002%
cql-keyvalue-astra (remaining,active,completed)=(97009,50,2991) 003%
cql-keyvalue-astra (remaining,active,completed)=(95856,50,4153) 004%
cql-keyvalue-astra (remaining,active,completed)=(94653,50,5347) 005%
cql-keyvalue-astra (remaining,active,completed)=(93494,50,6506) 007%
cql-keyvalue-astra (remaining,active,completed)=(92254,50,7746) 008%
cql-keyvalue-astra (remaining,active,completed)=(91024,50,8976) 009%
cql-keyvalue-astra (remaining,active,completed)=(89800,50,10200) 010%
cql-keyvalue-astra (remaining,active,completed)=(88588,50,11416) 011%
cql-keyvalue-astra (remaining,active,completed)=(87378,50,12622) 013%
...
cql-keyvalue-astra (remaining,active,completed)=(0,0,100000) 100% (last report)
```

## Run the main activity

Now that we have a base dataset of 50K rows in the database, we will now
run a mixed read / write workload, by default this runs a 50% read / 50%
write workload. This time we will add a `-v` option for more context.

```shell
 ./nb5 run driver=cql workload=cql-keyvalue tags='block:main.*' \
 cycles=50k cyclerate=5000 threads=50 --progress console:1s ...
```
You can go ahead and past your activity parameters on the end. nb5 will always parse out the 
global options (those with a dash) and leave your commands intact.

You should see output that looks like this:

```
Configured scenario log at ...
cql-keyvalue (remaining,active,completed)=(47168,1,2832) 006%
cql-keyvalue (remaining,active,completed)=(42059,2,7941) 016%
cql-keyvalue (remaining,active,completed)=(37107,2,12895) 026%
cql-keyvalue (remaining,active,completed)=(32060,1,17941) 036%
cql-keyvalue (remaining,active,completed)=(27060,2,22940) 046%
cql-keyvalue (remaining,active,completed)=(22058,2,27943) 056%
cql-keyvalue (remaining,active,completed)=(17058,1,32942) 066%
cql-keyvalue (remaining,active,completed)=(12059,2,37942) 076%
cql-keyvalue (remaining,active,completed)=(7059,1,42942) 086%
cql-keyvalue (remaining,active,completed)=(2060,1,47941) 096%
cql-keyvalue (remaining,active,completed)=(0,0,50000) 100% (last report)
```

We have a few new command line options here:

`tags=block:main` is using a new block in our workload template that contains both read and 
 write queries.

`threads=50` is an important one. The default for NoSQLBench is to run with a single thread. 
This is not adequate for workloads that will be running many operations, so threads is used as 
a way to increase concurrency on the client side.

`cyclerate=5000` is used to control the operations per second that are initiated by NoSQLBench. 
This command line option is the primary means to rate limit the workload and here we are 
running at 5000 ops/sec.

## Now What?

Note in the above output, we
see `Configured scenario log at logs/scenario_20230113_135200_029.log`.

By default, NoSQLBench records the metrics from the run in this file, we will go into detail 
 about these metrics in the next section [example results](../03_example_results).
