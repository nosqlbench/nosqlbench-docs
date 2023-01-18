---
title: "01 Commands"
weight: 2
---

Let's run a simple test against a cluster to establish some basic
familiarity with the NoSQLBench.

## Create a Schema

We will start by creating a simple schema in the database. From your
command line, go ahead and execute the following command, replacing
the `host=<host-or-ip>` with that of one of your database nodes.


```
./nb5 run driver=cql workload=cql-keyvalue tags=phase:schema host=<host-or-ip>
```
**NOTE:**
If you are using Astra DB for this tutorial, you need to make sure to modify the workload to `workload=cql-keyvalue-astra tags=phase:schema-astra`.
You also need to add the following parameters to your command:
`username=<client id>`, `password=<client secret>`,
and `secureconnectbundle=<path to scb zip file>`.

```sql
CREATE KEYSPACE baselines
 WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '1'}
 AND durable_writes = true;

CREATE TABLE baselines.keyvalue (
    key text PRIMARY KEY,
    value text
)
```

Let's break down each of those command line options.

`run` tells NoSQLBench to run an activity.

`driver=...` is used to specify the activity type (driver). In this case
we are using `cql`, which tells NoSQLBench to use the DataStax Java Driver
and execute CQL statements against a database.

`workload=...` is used to specify the workload definition file that
defines the activity.

In this example, we use `cql-keyvalue` which is a pre-built workload that
is packaged with NoSQLBench.

`tags=phase:schema` tells NoSQLBench to run the yaml block that has
the `phase:schema` defined as one of its tags.

In this example, that is the DDL portion of the `cql-keyvalue`
workload. `host=...` tells NoSQLBench how to connect to your database,
only one host is necessary.

If you like, you can verify the result of this command by describing your
keyspace in cqlsh or DataStax Studio with
`DESCRIBE KEYSPACE baselines`.

## Load Some Data

Before running a test of typical access patterns where you want to capture
the results, you need to make the test more interesting than loading an
empty table. For this, we use the rampup phase.

Before sending our test writes to the database, we will use the `stdout`
activity type, so we can see what NoSQLBench is generating for CQL
statements.

Go ahead and execute the following command:

    ./nb5 run driver=stdout workload=cql-keyvalue tags=phase:rampup cycles=10

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

NoSQLBench deterministically generates data, so the generated values will
be the same from run to run.

Now we are ready to write some data to our database. Go ahead and execute
the following from your command line:

    ./nb5 run driver=cql workload=cql-keyvalue tags=phase:rampup host=<host-or-ip> cycles=100k --progress console:1s

Note the differences between this and the command that we used to generate
the schema.

`tags=phase:rampup` is running the yaml block in `cql-keyvalue` that has
only INSERT statements.

`cycles=100k` will run a total of 100,000 operations, in this case,
100,000 writes. You will want to pick an appropriately large number of
cycles in actual testing to make your main test meaningful.

**NOTE:**
The cycles parameter is not just a quantity. It is a range of values.
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

## Run the main test phase

Now that we have a base dataset of 50K rows in the database, we will now
run a mixed read / write workload, by default this runs a 50% read / 50%
write workload. This time we will add a `-v` option for more context.

    ./nb5 run driver=cql workload=cql-keyvalue tags=phase:main host=<host-or-ip> cycles=50k cyclerate=5000 threads=50 --progress console:1s -v

You should see output that looks like this:

```
INFO  [main] NBCLI        Configured scenario log at logs/scenario_20230113_135200_029.log
cql-keyvalue-astra (remaining,active,completed)=(49689,50,311) 001%
cql-keyvalue-astra (remaining,active,completed)=(48506,44,1494) 003%
cql-keyvalue-astra (remaining,active,completed)=(44826,50,5174) 010%
cql-keyvalue-astra (remaining,active,completed)=(41134,50,8866) 018%
cql-keyvalue-astra (remaining,active,completed)=(37450,50,12550) 025%
cql-keyvalue-astra (remaining,active,completed)=(33797,50,16203) 032%
cql-keyvalue-astra (remaining,active,completed)=(30091,50,19909) 040%
cql-keyvalue-astra (remaining,active,completed)=(26372,50,23628) 047%
cql-keyvalue-astra (remaining,active,completed)=(22776,50,27224) 054%
cql-keyvalue-astra (remaining,active,completed)=(19101,50,30899) 062%
cql-keyvalue-astra (remaining,active,completed)=(15435,50,34565) 069%
cql-keyvalue-astra (remaining,active,completed)=(11771,50,38229) 076%
cql-keyvalue-astra (remaining,active,completed)=(8121,50,41879) 084%
cql-keyvalue-astra (remaining,active,completed)=(4554,50,45446) 091%
cql-keyvalue-astra (remaining,active,completed)=(922,50,49078) 098%
cql-keyvalue-astra (remaining,active,completed)=(0,0,50000) 100% (last report)

```

We have a few new command line options here:

`tags=phase:main` is using a new block in our activity's yaml that
contains both read and write queries.

`threads=50` is an important one. The default for NoSQLBench is to run
with a single thread. This is not adequate for workloads that will be
running many operations, so threads is used as a way to increase
concurrency on the client side.

`cyclerate=5000` is used to control the operations per second that are
initiated by NoSQLBench. This command line option is the primary means to
rate limit the workload and here we are running at 5000 ops/sec.

## Now What?

Note in the above output, we
see `Configured scenario log at logs/scenario_20230113_135200_029.log`.

By default, NoSQLBench records the metrics from the run in this file, we
will go into detail about these metrics in the next section Viewing
Results.
