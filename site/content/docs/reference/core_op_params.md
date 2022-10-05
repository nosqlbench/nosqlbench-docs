---
title: "Core Op Parameters"
weight: 21
---

Some statement parameters are recognized by the nosqlbench runtime and can
be used on any statement in a YAML file.

## *ratio*

A statement parameter called _ratio_ is supported by every workload. It
can be attached to a statement, or a block or a document level parameter
block. It sets the relative ratio of a statement in the op sequence before
an activity is started.

When an activity is initialized, all the active statements are combined
into a sequence based on their relative ratios. By default, all statement
templates are initialized with a ratio of 1 if non is specified by the
user.

For example, consider the statements below:

```yaml
statements:
    - s1: "select foo,bar from baz where ..."
      ratio: 1
    - s2: "select bar,baz from foo where ..."
      ratio: 2
    - s3: "select baz,foo from bar where ..."
      ratio: 3
```

If all statements are activated (there is no tag filtering), then the
activity will be initialized with a sequence length of 6. In this case,
the relative ratio of statement "s3" will be 50% overall. If you filtered
out the first statement, then the sequence would be 5 operations long. In
this case, the relative ratio of statement "s3" would be 60% overall. It
is important to remember that statement ratios are always relative to the
total sum of the active statements' ratios.

This op param works closely with the core activity parameter named [seq](../core-activity-parameters/#seq) 

