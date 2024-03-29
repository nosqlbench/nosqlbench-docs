---
title: "Core Op Fields"
weight: 22
---

Some op template fields are reserved by nb5. These are provided by the runtime, not any 
particular driver, and can be used in any op template.

👉 op fields can be defined at any level of a workload template with a `param` property. Op 
template which do not have this op field by name will automatically inherit it.

# Core Op Fields

## *driver*

- _default_: unset
- _required_: yes, by op template or by activity params
- _dynamic_: no

Each op template in an activity can use a specific driver.  If this op field is not provided in 
the op template, then it is set by default from the activity params. If neither is set, an error 
is thrown.

Since each op template can have a unique driver, and each activity can have multiple op 
templates, each activity will have multiple drivers active while it is running. These drivers 
are instanced and shared between op templates which specify the same driver by name.

During activity initialization, all the drivers which are loaded by active op templates (those 
not filtered out) are consulted for valid activity params. Only params which are valid for at least 
one active driver will be allowed to be set on the activity. This includes [core activity 
params](@/user-guide/core-activity-params.md).

## *space*

- _default_: "default"
- _required_: yes, but set by default
- _dynamic_: yes

The space is a named cache of driver state. For each driver, a cache of driver-specific "driver 
space" objects is kept. If the value is not set in the op template, then the effect is the same 
as all op templates sharing a single instance of a driver for a given name (Where the name is 
the same for multiple op templates). However, if the users sets the `space` op field to 
a binding, then the driver will be virtualized over the names provided, allowing for a given 
driver to be effectively multi-instanced within the activity.

👉 **Be careful with this op field!** The way it works allows for quite advanced testing 
scenarios to be built with _very minimal_ effort, compared to nearly all other approaches. 
However, if you set this op field to a binding function which produces a high cardinality values,
you will be asking your client to create many instances of a native driver. This is not likely 
to end well for at least the client, and in some cases the server. This does present interesting 
stress testing scenarios, however!

When an activity is shutting down, it will automatically close out any driver spaces 
according to their own built-in shutdown logic, but not until the activity is complete. At 
present, there is no space cache expiry mechanism, but this can be added if someone
needs it.

## *ratio*

An op field called _ratio_ can be specified on an op template to set the number of times this op 
will occur in the op sequence.

When an activity is initialized, all the active statements are combined into a sequence based 
on their relative ratios. By default, all op templates are initialized with a ratio of 
1 if none is specified by the user.

For example, consider the op templates below:

```yaml

ops:
  s1:
    op: "select foo,bar from baz where ..."
    ratio: 1
  s2:
    op: "select bar,baz from foo where ..."
    ratio: 2
  s3: 
    op: "select baz,foo from bar where ..."
    ratio: 3
```

If all ops are activated (there is no tag filtering), then the activity will be initialized 
with a sequence length of 6. In this case, the relative ratio of op "s3" will be 50% overall. 
If you filtered out the first op, then the sequence would be 5 operations long. In this case, 
the relative ratio of op "s3" would be 60% overall. It is important to remember that op ratios 
are always relative to the total sum of the active ops' ratios.

This op field works closely with the core activity 
parameter [seq](../core-activity-parameters/#seq) 

## instrument

By setting this to true, each named op template will be instrumented with a set of metrics, with 
the metric name derived from its op name.

For example, with the following workload template:

```yaml
ops:
 op1:
   op: "example stmt1"
   instrument: true
 op2:
   op: "example stmt2"
   instrument: true
```
With instrument _enabled_ for each of these ops, six additional metrics will be created:
four [timers](https://metrics.dropwizard.io/4.2.0/manual/core.html#timers) named op1-success, 
op1-error, op2-success, and op2-error, and two
[histograms](https://metrics.dropwizard.io/4.2.0/manual/core.html#man-core-histograms) named
op1-result-size and op2-result size.

This is very useful for understanding performance dynamics of individual operations. However, be 
careful when enabling this for a large number of metrics (by setting it as a doc or block level 
param), especially when you are running with more than 3 significant digits of HDR histogram 
precision.

## start-timers
## stop-timers

This op fields allow for a timer or set of timers to be started immediately before an operation is 
started and stopped immediately after another (or the same!) operation is completed. This allows 
you to instrument your access patterns with arbitrary timers across any number of operations.

These timers are started and stopped unconditionally, which means failed operations will be 
included. Be sure to correlate your metrics so you know what you are truly measuring.

For example:

```yaml
ops:
  op1:
    op: "example stmt1"
    start-timers: stanza1, stanza2
  op2:
    op: "example stmt2"
    stop-timers: stanza1
  op3:
    op: "example stmt"
    stop-timers: stanza2
```
In this case, before op1 is executed, a timer is started for stanza1 and stanza2. After op2 has 
been executed, successful or not, the timer for stanza1 will be stopped. After 
op3 has been executed, successful or not, the timer named stanza2 will be stopped.

These are treated just like any other timers, with a single named instance per activity, thus 
the measurements are an aggregate over all threads.

👉 The instancing of these named timers is per-thread! There is no way to cross the streams, so 
measurements are coherent within serialized operations which represent real access patterns in a 
given application thread.


## verifier

You can now verify results of operations using property-based assertions or result equality.
These methods use a compiled script which has access to binding variables in the same way that
op templates use them, as bind points like `... {mybinding} ...`. This means that you can write
script for verification logic naturally. The verification script is parsed and compiled ahead of 
time, with full awareness of the bindings which need to be generated before per-cycle evaluation.

The verifier is implemented in groovy 4, and is thus compatible with typical Java forms. It also 
allows for some terse and simplified views for assertion-based testing. Consult the [Groovy 
Language Documentation](https://docs.groovy-lang.org/latest/html/documentation/) or 
the [Groovy API docs](https://docs.groovy-lang.org/latest/html/api/) for more details on the 
language.

Within the scripting environment of verifier, the result of the last operation is accessed as the
`result` variable. This makes assertion logic read like what it does. For example, if you want 
to verify that the result of an operation is equal to the string "this worked 42!", you can 
specify something like this:

```yaml
ops:
  op1:
     stmt: "this worked 42!\n"
     verifier: |
      result.equals("this worked 42!\n");
```

The verifier allows you to use bindings in exactly the same format as your string-based op 
templates:
```yaml
ops:
  op1:
    stmt: "this worked {numname}!\n"
    verifier: |
      result.equals("this worked ${numname}!\n");
    bindings:
     numname: NumberNameToString();
```

This example doesn't do much like a real test would, since it is simply asserting that the 
result looks the way we know it should. However, this mechanism can be used in any scenario
where you know a property or feature of a result that you can check for to verify correctness.

The verifier can be specified as a string, list, or map structure. In each case, the form is
interpreted as a sequence of named verifiers. in the string or list forms, names are created for
you. These names may be used in logging or other views needed to verify or troubleshoot the actual
logic of your verifier script.

When multiple verifiers are supplied, they are executed each in turn. This means that errors will 
present distinctly when verifiers are separated for clarity.

All verifier execution contexts share the same compiled script for a given verifier code body, but 
each thread has its own instanced variable state, including results.

## expected-result

If you want to test with a more concise and declarative form, and your result content isn't complex,
you can use the `expected-result` op field instead. This form allows you to prototype an object
in declarative or literal form which can then be checked against a result using Java equals 
semantics. For example, to verify the same result as shown with the verifier above, but in a 
simpler form, you could do this:

```yaml
ops:
  op1:
    stmt: "this worked {numname}!\n"
    expected-result: "this worked "+{numname}+"!\n"
    bindings:
     numname: NumberNameToString();
```

Since the expected-result value is rendered by active code, you must treat it as code where the 
bind points are simply injected variables. This form can also use container types and inline or 
literal forms.

## verifier-imports

For the verifier capabilities explained above, you may need to import symbols from packages in
your runtime. This allows you to do so. These imports will apply equally to any per-cycle 
verification logic for the given op template, and only need to be specified once (per op template).


