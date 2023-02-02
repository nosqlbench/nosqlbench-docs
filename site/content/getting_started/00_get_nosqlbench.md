---
title: "00 Download"
weight: 10
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


## Download Scripts

```shell
# download the latest nb5 jar
curl -L -O https://github.com/nosqlbench/nosqlbench/releases/latest/download/nb5.jar
java -jar nb5.jar --version
```

```shell
# download the latest nb5 binary and make it executable
curl -L -O https://github.com/nosqlbench/nosqlbench/releases/latest/download/nb5
chmod +x nb5
./nb5 --version
```

**NOTE:**
If after downloading and executing nb, you get an error, please consult the
[[AppImage troubleshooting page](https://docs.appimage.org/user-guide/run-appimages.html#troubleshooting)]
.

This documentation assumes you are using the Linux binary initiating NoSqlBench commands with
`./nb`. If you are using the jar, just replace `./nb` with `java -jar nb.jar` when running
commands. If you are using the jar version, Java 17 is recommended, and will be required soon.

## Run a cluster

This section requires you to have a CQL system to connect to. If you don’t already have one,
you can start an instance of DSE with this one-liner:

    docker run -e DS_LICENSE=accept --name my-dse -p 9042:9042 -d datastax/dse-server:6.8.17-ubi7

or consult the instructions at the
[[Apache Cassandra docker hub landing page](https://hub.docker.com/_/cassandra)].

## Running

To run a simple built-in workload run:

    ./nb5 cql-iot

To get a list of built-in scenarios run:

    # Get a list of all named scenarios and parameters
    ./nb5 --list-scenarios

If you want a simple list of yamls which contain named scenarios, run:

    # Get a simple list of yamls containing named scenarios
    ./nb5 --list-workloads

👉 These commands will include workloads that were shipped with nb5 and
workloads in your local directory. To learn more about how to design
custom workloads see
[[designing workloads](/../workloads_101)].

To provide your own contact points (comma separated), add the `hosts=`
parameter

    ./nb5  cql-iot hosts=host1,host2

Additionally, if you have docker installed on your local system, and your user has permissions to
use it, you can use
`--docker-metrics` to stand up a live metrics dashboard at port 3000.

    ./nb5  cql-iot --docker-metrics

This example doesn't go into much detail about what it is doing. It is here to show you how quickly
you can start
running real workloads without having to learn much about the machinery that makes it happen.

The rest of this section has a more elaborate example that exposes some of
the basic options you may want to adjust for your first serious test.

**NOTE:**
If you want to see system-level metrics from your cluster, it is possible
to get these as well as Apache Cassandra level metrics by using the DSE
Metrics Collector (if using DSE), or by setting up a metrics feed to the
Prometheus instance in your local docker stack. You can find the DSE
Metrics Collector docs
[here](https://docs.datastax.com/en/monitoring/doc/monitoring/metricsCollector/mcExportMetricsDocker.html)
.

[^1]: The version scheme for NoSQLBench is [major]-[java-lts]-[minor], so nb5 version 5.17.1 
requires java version 17, which is the latest LTS Java release.
