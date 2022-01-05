---
title: "Parameter Types"
weight: 15
---

To configure a NoSQLBench activity to do something meaningful, you have to provide parameters to it.
This can occur in one of several ways. This section is a guide on NoSQLBench parameters, how they
layer together, and when to use one form over another.

The command line is used to configure both the overall runtime (logging, etc) as well as the
individual activities and scripts. Global options can be distinguished from scenario commands and
their parameters because global options always start with a `-single` or `--double-hyphen`.

## Activity Parameters

Parameters for an activity always have the form of `<name>=<value>` on the command line. Activity
parameters *must*
follow a command, such as `run` or `start`, for example. Scenario commands are always single words
without any leading hyphens. Every command-line argument that follows a scenario command in the form
of `<name>=<value>` is a parameter to that command.

Activity parameters can be provided by the core runtime, or they can be provided by a driver. It's
not important where they are provided from so long as you know what they do for your workloads, how
to configure them, and where to find the docs.

*Core* Parameters are those provided by the core runtime. They are part of the core API and used by
every activity type. Core activity params include type*, *alias*, and *threads*, for example. These
parameters are explained individually under the next
section, [Activity Params](../activity-parameters).

*Driver* Parameters are those provided by an activity type. These parameters are documented for each
activity type. You can see them by running `nb help <activity type>`.

Driver parameters may be dynamic. *Dynamic* Activity Parameters are parameters which may be changed
while an activity is running. This means that scenario scripting logic may change some variables
while an activity is running, and that the runtime should dynamically adjust to match. Dynamic
parameters are mainly used in more advanced scripting scenarios.

Parameters that are dynamic should be documented as such where they are described.

### Op Params

Within a workload definition, op templates can be defined with parameters which are meant to 
configure that specific operation. Params such as `prepared`, which enables or disables prepared 
statements in CQL workloads are meaningful only for a given type of operation.

### Template Parameters

If you need to provide general-purpose overrides to a named section of the standard YAML, then you
may use a mechanism called _template parameters_. These are just like activity parameters, but they
are set via macro and cna have defaults. This is a YAML format feature that allows you to easily
template workload properties in a way that is easy to override on the command line or via scripting.
More details on template parameters are shared under 'Designing Workloads|Template Params'.

### Parameter Loading

Now that we've described all the parameter types, let's tie them together. When an activity is
loaded from the command line or script, the parameters are resolved in the following order:

1. The `driver` parameter tells NoSQLBench which activity type implementation to load.
2. The activity driver implementation creates an activity.
3. The activity is initialized with the remaining parameters.
    1. The workload parameter is used to load the workload definition into a buffer without parsing
       the YAML
    2. Any template parameters in the file in `<<varname:default value>>`
       or `TEMPLATE(varname, default value)` form are resolved, taking override values from the
       provided params. Any matching params are removed from the list before further processing.
    3. The activity initializes all op templates, using any supported activity parameters.
6. Finally, the activity is started.

## Op Params

Some activities make use of named parameters for op templates. These are called _op params_ and are
completely different than _activity parameters_. Op params in a YAML allow you to affect *how* an
opeation executes as part of a workload. Just as with activity level parameters, op
params may be supported by the core runtime or by an activity type. These are also documented in
the respective driver's documentation.



