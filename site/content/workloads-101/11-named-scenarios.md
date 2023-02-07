---
title: "11 Named Scenarios"
sort_by: "weight"
weight: 111
---

There is one final element of a yaml that you need to know about: _named scenarios_.

**Named Scenarios allow anybody to run your testing workflows with a single command.**

You can provide named scenarios for a workload like this:

```yaml
# contents of myworkloads.yaml
scenarios:
  default:
    - run driver=diag cycles=10 alias=first-ten
    - run driver=diag cycles=10..20 alias=second-ten
  longrun:
    - run driver=diag cycles=10M
```

This provides a way to specify more detailed workflows that users may want to run without them
having to build up a command line for themselves.

A couple of other forms are supported in the YAML, for terseness:

```yaml
scenarios:
  oneliner: run driver=diag cycles=10
  mapform:
    part1: run driver=diag cycles=10 alias=part2
    part2: run driver=diag cycles=20 alias=part2
```

These forms simply provide finesse for common editing habits, but they are automatically read
internally as a list of named steps. In the map form, the names are used to name activities. The
order is retained.

## Scenario selection

When a named scenario is run, it is *always* named, so that it can be looked up in the list of named
scenarios under your `scenarios:` property. The only exception to this is when an explicit scenario
name is not found on the command line, in which case it is automatically assumed to be `default`.

Some examples may be more illustrative:

```
# runs the scenario named 'default' if it exists, or throws an error if it does not.
nb5 myworkloads
# or
nb5 myworkloads default

# runs the named scenario 'longrun' if it exists, or throws an error if it does not.
nb5 myworkloads longrun

# runs the named scenario 'longrun' if it exists, or throws an error if it does not.
# this is simply the canonical form which is more verbose, but more explicit.
nb5 scenario myworkloads longrun

# run multiple named scenarios from one workload, and then some from another
nb5 scenario myworkloads longrun default longrun scenario another.yaml name1 name2
# In this form ^ you may have to add the explicit form to avoid conflicts between
# workload names and scenario names. That's why the explicit form is provided, afterall.
```

## Workload selection

The examples above contain no reference to a workload (formerly called _
yaml_). They don't need to, as they refer to themselves implicitly. You may add a `workload=`
parameter to the command templates if you like, but this is never needed for basic use, and it is
error-prone to keep the filename matched to the command template. Just leave it out by default.

_However_, if you are doing advanced scripting across multiple systems, you can actually provide
a `workload=` parameter particularly to use another workload description in your test.

👉 This is a powerful feature for workload automation and organization. However, it can get unwieldy
quickly. Caution is advised for deep-linking too many scenarios in a workspace, as there is no
mechanism for keeping them in sync when small changes are made.

## Named Scenario Discovery

For named scenarios, there is a way for users to find all the named scenarios that are currently
bundled or in view of their current directory. A couple simple rules must be followed by scenario
publishers in order to keep things simple:

1. Workload files in the current directory `*.yaml` are considered.
2. Workload files under in the relative path `activities/` with name `*.yaml` are considered.
3. The same rules are used when looking in the bundled NoSQLBench, so built-ins come along for the
   ride.
4. Any workload file that contains a `scenarios:` tag is included, but all others are ignored.

This doesn't mean that you can't use named scenarios for workloads in other locations. It simply
means that when users use the `--list-scenarios` option, these are the only ones they will see
listed.

## Parameter Overrides

You can override parameters that are provided by named scenarios. Any parameter that you specify on
the command line after your workload and optional scenario name will be used to override or augment
the commands that are provided for the named scenario.

This is powerful, but it also means that you can sometimes munge user-provided activity parameters
on the command line with the named scenario commands in ways that may not make sense. To solve this,
the parameters in the named scenario commands may be locked. You can lock them silently, or you can
provide a verbose locking that will cause an error if the user even tries to adjust them.

Silent locking is provided with a form like `param==value`. Any silent locked parameters will reject
overrides from the command line, but will not interrupt the user.

Verbose locking is provided with a form like `param===value`. Any time a user provides a parameter
on the command line for the named parameter, an error is thrown and they are informed that this is
not possible. This level is provided for cases in which you would not want the user to be unaware of
an unset parameter which is germain and specific to the named scenario.

All other parameters provided by the user will take the place of the same-named parameters provided
in *each* command templates, in the order they appear in the template. Any other parameters provided
by the user will be added to *each*
of the command templates in the order they appear on the command line.

This is a little counter-intuitive at first, but once you see some examples it should make sense.

## Parameter Override Examples

Consider a simple workload with three named scenarios:

```yaml
# basics.yaml
scenarios:
  s1: run driver=stdout cycles=10
  s2: run driver=stdout cycles==10
  s3: run driver=stdout cycles===10

bindings:
  c: Identity()

statements:
  - A: "cycle={c}\n"
```

Running this with no options prompts the user to select one of the named scenarios:

```
$ nb5 basics
ERROR: Unable to find named scenario 'default' in workload 'basics', but you can pick from s1,s2,s3
$
```

### Basic Override example

If you run the first scenario `s1` with your own value for `cycles=7`, it does as you ask:

```
$ nb5 basics s1 cycles=7
Logging to logs/scenario_20200324_205121_554.log
cycle=0
cycle=1
cycle=2
cycle=3
cycle=4
cycle=5
cycle=6
$
```

### Silent Locking example

If you run the second scenario `s2` with your own value for `cycles=7`, then it does what the locked
parameter
`cycles==10` requires, without telling you that it is ignoring the specified value on your command
line.

```
$ nb5 basics s2 cycles=7
Logging to logs/scenario_20200324_205339_486.log
cycle=0
cycle=1
cycle=2
cycle=3
cycle=4
cycle=5
cycle=6
cycle=7
cycle=8
cycle=9
$
```

Sometimes, this is appropriate, such as when specifying settings like `threads==` for schema 
activities.

### Verbose Locking example

If you run the third scenario `s3` with your own value for `cycles=7`, then you will get an error
telling you that this is not possible. Sometimes you want to make sure tha the user knows a
parameter should not be changed, and that if they want to change it, they'll have to make their own
custom version of the scenario in question.

```
$ nb5 basics s3 cycles=7
ERROR: Unable to reassign value for locked param 'cycles===7'
$
```

Ultimately, it is up to the scenario designer when to lock parameters for users. The built-in
workloads offer some examples on how to set these parameters so that the right value are locked in
place without bother the user, but some values are made very clear in how they should be set. Please
look at these examples for inspiration when you need.

## Forcing Undefined Parameters

If you want to ensure that any parameter in a named scenario template remains unset in the generated
scenario script, you can assign it a value of `UNDEF`. The locking behaviors described above apply to
this one as well. Thus, for schema commands which rely on the default sequence length (which is
based on the number of active statements), you can set `cycles==UNDEF` to ensure that when a user
passes a cycles parameter, the schema activity doesn't break with too many cycles.

## Automatic Parameters

Some parameters are already known due to the fact that you are using named scenarios.

*workload*

The `workload` parameter is, by default, set to the logical path (fully qualified workload name) of
the yaml file containing the named scenario. However, if the command template contains this
parameter, it may be overridden by users as any other parameter depending on the assignment
operators as explained above.

*alias*

The `alias` parameter is, by default, set to the expanded name of WORKLOAD_SCENARIO_STEP, which
means that each activity within the scenario has a distinct and symbolic name. This is important for
distinguishing metrics from one another across workloads, named scenarios, and steps within a named
scenario. The above words are interpolated into the alias as follows:

- WORKLOAD - The simple name part of the fully qualified workload name. For example, with a
  workload (yaml path) of foo/bar/baz.yaml, the WORKLOAD name used here would be `baz`.

- SCENARIO - The name of the scenario as provided on the command line.

- STEP - The name of the step in the named scenario. If you used the list or string forms to provide
  a command template, then the steps are automatically named as a zero-padded number representing
  the step in the named scenario, starting from `000`, per named scenario. (The numbers are not
  globally assigned)

Because it is important to have uniquely named activities for the sake of sane metrics and logging,
any alias provided when using named scenarios which does not include the three tokens above will
cause a warning to be issued to the user explaining why this is a bad idea.

👉 UNDEF is handled before alias expansion above, so it is possible to force the default activity
naming behavior above with `alias===UNDEF`. This is generally recommended, and will inform users if
they try to set the alias in an unsafe way.


