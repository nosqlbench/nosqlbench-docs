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

This will be explained further in [Scenarios](@/getting-started/02-scenarios.md).

# Options

Here is a more detailed command which demonstrates how customizable nb5 is:

```shell,linenos
./nb5 examples/bindings-basics default \
 filename=exampledata.out \
 format=csv \
 cycles=10000 \
 rate=100 \
 --progress console:1s
```
Each line does somethign specific:
1. Starts the scenario named default from the the workload template examples/binding-basics.
2. Sets the filename parameter (part of the stdout driver) to exampledata.out. 
3. Sets the output format (part of the stdout driver) to CSV. 
4. Sets the number of cycles to run to 10000, short for 0..10000, which includes 0 through 9999. 
5. Sets the cycle rate to 100 per second. 
6. Tells nb5 to report activity progress to the console every second.

# Dashboards

You can use `--docker-metrics` to stand up a live metrics dashboard at port 3000.

👉In order to use the `--docker-metrics` option, you need to have docker installed on your 
local system, and your user must have permissions to use it. Typically, this means that your user 
has been added to the docker group with a command like `sudo usermod $USER -g docker`.

Here is the above command, with built-in dashboarding enabled:

```shell
./nb5 examples/bindings-basics default \
 filename=exampledata.out \
 format=csv \
 cycles=10000 \
 rate=100 \
 --progress console:1s \
 --docker-metrics
```

[^1]: The version scheme for NoSQLBench is [major]-[java-lts]-[minor], so nb5 version 5.17.1 
requires java version 17, which is the latest LTS Java release.
