---
title: "00 Download"
weight: 100
---

NoSQLBench version 5 is packaged directly as a Linux binary named
[nb5](https://github.com/nosqlbench/nosqlbench/releases/latest/download/nb5)
and as an executable Java 17 jar named
[nb5.jar](https://github.com/nosqlbench/nosqlbench/releases/latest/download/nb5.jar)
. All releases are available at
[[NoSQLBench Releases](https://github.com/nosqlbench/nosqlbench/releases)]. The Linux binary is
recommended, since it comes with its own JVM and eliminates the need to manage
Java downloads.

# Requirements

The nb5 binary requires Linux and a system with a working
[FUSE](https://en.wikipedia.org/wiki/Filesystem_in_Userspace) library. Most modern distributions
have this out of the box.

nb5.jar is not particular about what system you run it on, as long as you have java 17 or newer.[^1]


# Download Scripts

## Get the latest nb5 binary

```shell
# download the latest nb5 binary and make it executable
curl -L -O https://github.com/nosqlbench/nosqlbench/releases/latest/download/nb5
chmod +x nb5
./nb5 --version
```

👉 If after downloading and executing nb, you get an error, please consult the
[AppImage troubleshooting page](https://docs.appimage.org/user-guide/run-appimages.html#troubleshooting).

## Get the latest nb5 jar

```shell
# download the latest nb5 jar
curl -L -O https://github.com/nosqlbench/nosqlbench/releases/latest/download/nb5.jar
java -jar nb5.jar --version
```

This documentation assumes you are using the Linux binary initiating NoSqlBench commands with
`./nb`. If you are using the jar, just replace `./nb` with `java -jar nb.jar` when running
commands. If you are using the jar version, Java 17 is recommended, and will be required soon.

# Running nb5

To run a simple built-in workload run:

    ./nb5 examples/bindings-basics

This runs a built-in scenario located in the _workload template_ named 'bindings-basics'. The 
file that the scenario is defined in is called the _workload template_. The scenario is named 
`default`, so you don't even have to specify it here. But you could, as

    ./nb5 examples/bindings-basics default

To get a list of built-in scenarios run:

    # Get a list of all named scenarios and parameters
    ./nb5 --list-scenarios

If you want a simple list of _workload templates_ which contain _named scenarios_, run:

    # Get a simple list of workload templates containing named scenarios
    ./nb5 --list-workloads

    # Get a list of workload templates including examples.
    # These can be run just like the example above.
    ./nb5 --list-workloads --include examples

👉 These commands will include workloads that were shipped with nb5 and workloads in your local 
 directory. To learn more about how to design custom workloads see
[[designing workloads](/../workloads-101)].

Additionally, if you have docker installed on your local system, and your user has permissions to
use it, you can use
`--docker-metrics` to stand up a live metrics dashboard at port 3000.

    ./nb5  cql-iot --docker-metrics

The rest of this section goes into more detail with a real CQL workload.

👉 If you want to see system-level metrics from your cluster, it is possible to get these as 
well as Apache Cassandra level metrics by using the DSE Metrics Collector (if using DSE), or 
by setting up a metrics feed to the Prometheus instance in your local docker stack. You can 
read the 
[DSE Metrics Collector docs](https://docs.datastax.com/en/monitoring/doc/monitoring/metricsCollector/mcExportMetricsDocker.html).

[^1]: The version scheme for NoSQLBench is [major]-[java-lts]-[minor], so nb5 version 5.17.1 
requires java version 17, which is the latest LTS Java release.
