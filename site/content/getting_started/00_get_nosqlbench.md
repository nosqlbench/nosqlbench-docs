---
title: "00 Install"
weight: 1
---

NoSQLBench is packaged directly as a Linux binary named `nb` and as an executable Java jar named `nb.jar`.

## Downloading

The Linux binary is recommended, since it comes with its own JVM and eliminates the need to manage Java downloads. Both
can be obtained at [[NoSQLBench Releases](https://github.com/nosqlbench/nosqlbench/releases)].

**NOTE:**
Once you download the binary, you may need to `chmod +x nb` to make it executable. In order to 
run AppImage binaries, like nb, you need to have fuse support on your system. This is already 
provided on most distributions. If after downloading and executing nb, you get an error,
please consult the 
[[AppImage troubleshooting page](https://docs.appimage.org/user-guide/run-appimages.html#troubleshooting)]
.

This documentation assumes you are using the Linux binary initiating  NoSqlBench commands with
`./nb`. If you are using the jar, just  replace `./nb` with `java -jar nb.jar` when running 
commands. If you are using the jar version, Java 17 is recommended, and will be required soon.

## Run a cluster

This section requires you to have a CQL system to connect to.  If you don’t already have one, 
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

Additionally, if you have docker installed on your local system, and your user has permissions to use it, you can use
`--docker-metrics` to stand up a live metrics dashboard at port 3000.

    ./nb5  cql-iot --docker-metrics

This example doesn't go into much detail about what it is doing. It is here to show you how quickly you can start
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

## Run a cluster (Astra DB)

Alternatively, you can choose to run a serverless cluster through AstraDB for functional testing. For tips on how to set-up an Astra DB instance,
you can check out this [[Astra Tutorial](https://github.com/datastaxdevs/workshop-intro-to-cassandra#2-create-a-table)].

If you plan to follow along this tutorial using AstraDB, you will need to follow these steps: 
- Add a keyspace named 'baselines' to your Astra Database (this is because Astra does not support adding keyspaces through CQLSH),
see the following for details:

  ![Keyspace](/../getting_started/keyspace.png)

- Add an IP to connect to your DB Instance, you can do that by going to the settings of your Astra DB 
and clicking 'Add Access'. Make note of your IP.

- In the connect menu of your Astra DB Instance, download your secure connect bundle and make note of its path.

- In your organization settings, you need to generate a Read/Write token and make note of the Client ID and Client Secret. 
see below for details:

  ![Token](/../getting_started/token.png)