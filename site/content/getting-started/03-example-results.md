+++
title= "03 Results"
weight= 103
+++

We just ran a very simple workload against our database. In that example, we saw that nb5
writes to a log file, and it is in that log file where the most basic form of metrics are displayed.

## Log File Metrics

For our previous run, we saw that NoSQLBench was writing to a 
file like `logs/scenario_20190812_154431_028.log`

Even when you don't configure NoSQLBench to write its metrics to another location, it will
periodically report all the metrics to the log file. At the end of a scenario, before NoSQLBench
shuts down, it will flush the partial reporting interval again to the logs. This means you can
always look in the logs for metrics information.

**WARNING:**
If you look in the logs for metrics, be aware that the last report will only contain a partial
interval of results. When looking at the last partial window, only metrics which average over time
or which compute the mean for the whole test will be meaningful.

Below is a sample of the log that gives us our basic metrics. There is a lot to digest here, for now
we will only focus a subset of the most important metrics.

```
2019-08-12 15:46:00,274 INFO [main] i.e.c.ScenarioResult [ScenarioResult.java:48] -- BEGIN METRICS DETAIL --
2019-08-12 15:46:00,294 INFO [main] i.e.c.ScenarioResult [Slf4jReporter.java:373] type=GAUGE, name=cql-keyvalue.cycles.config.burstrate, value=5500.0
2019-08-12 15:46:00,295 INFO [main] i.e.c.ScenarioResult [Slf4jReporter.java:373] type=GAUGE, name=cql-keyvalue.cycles.config.cyclerate, value=5000.0
2019-08-12 15:46:00,295 INFO [main] i.e.c.ScenarioResult [Slf4jReporter.java:373] type=GAUGE, name=cql-keyvalue.cycles.waittime, value=3898782735
2019-08-12 15:46:00,298 INFO [main] i.e.c.ScenarioResult [Slf4jReporter.java:373] type=HISTOGRAM, name=cql-keyvalue.resultset-size, count=100000, min=0, max=1, mean=8.0E-5, stddev=0.008943914131967056, median=0.0, p75=0.0, p95=0.0, p98=0.0, p99=0.0, p999=0.0
2019-08-12 15:46:01,703 INFO [main] i.e.c.ScenarioResult [ScenarioResult.java:56] -- END METRICS DETAIL --
```

The log contains lots of information on metrics, but this is obviously _not_ the most desirable way
to consume metrics from NoSQLBench.

We recommend that you use one of these methods, according to your environment or tooling available:

1. Send your metrics to a dedicated graphite server with `--report-graphite-to graphitehost`
2. Record your metrics to local CSV files with `--report-csv-to my_metrics_dir`
3. Record your metrics to HDR logs with `--log-histograms my_hdr_metrics.log`

See the command line reference for details on how to route your metrics to a metrics collector or
format of your preference.
