---
title: "05 Op Tags"
sort_by: "weight"
weight: 105
---

## Op Tags Defined

Tags are used to mark and filter groups of op templates for controlling which ones get used in a
given scenario. Tags are generally free-form, but there is a set of conventions that can make your
testing easier.

An example:

```yaml
tags:
 name: foxtrot
 unit: bravo
```

## Tag Filtering Rules

The tag filters provide a flexible set of conventions for filtering tagged statements. Tag filters
are usually provided as an activity parameter when an activity is launched. The rules for tag
filtering are:

0. If no conjugate is specified, `all(...)` is assumed. This is in keeping with the previous
   default. If you do specify a conjugate wrapper around the tag filter, it must be in one of 
   these forms: `all(...)`, `any(...)`, or `none(...)`.
1. If no tag filter is specified, then the op template matches.
2. A tag name predicate like `tags=name` asserts the presence of a specific tag name, regardless of
   its value.
3. A tag value predicate like `tags=name:foxtrot` asserts the presence of a specific tag name and a
   specific value for it.
4. A tag pattern predicate like `tags=name:'fox.*'` asserts the presence of a specific tag name and
   a value that matches the provided regular expression.
5. Multiple tag predicates may be specified as in `tags=name:'fox.*',unit:bravo`
6.
    0. If the `all` conjugate form is used (the default), then if any predicate fails to match a
       tagged element, then the whole tag filtering expression fails to match.
    1. If the `any` conjugate form is used, then if all predicates fail to match a tagged element,
       then the whole tag filtering expression fails to match.
    2. If the `none` conjugate form is used, then if any predicate _matches_, a tagged element, then
       the whole tag filtering expression matches.

## Tag Filtering Examples

A demonstration:

```yaml
# stdout-test.yaml
tags:
 name: foxtrot
 unit: bravo
statements:
 - "I'm alive!\n"
```

```shell
# no tag filter matches any
[test]$ ./nb5 run driver=stdout workload=stdout-test
I'm alive!

# tag name assertion matches
[test]$ ./nb5 run driver=stdout workload=stdout-test tags=name
I'm alive!

# tag name assertion does not match
[test]$ ./nb5 run driver=stdout workload=stdout-test tags=name2
02:25:28.158 [scenarios:001] ERROR i.e.activities.stdout.StdoutActivity - Unable to create a stdout statement if you have no active statements or bindings configured.

# tag value assertion does not match
[test]$ ./nb5 run driver=stdout workload=stdout-test tags=name:bravo
02:25:42.584 [scenarios:001] ERROR i.e.activities.stdout.StdoutActivity - Unable to create a stdout statement if you have no active statements or bindings configured.

# tag value assertion matches
[test]$ ./nb5 run driver=stdout workload=stdout-test tags=name:foxtrot
I'm alive!

# tag pattern assertion matches
[test]$ ./nb5 run driver=stdout workload=stdout-test tags=name:'fox.*'
I'm alive!

# tag pattern assertion does not match
[test]$ ./nb5 run driver=stdout workload=stdout-test tags=name:'tango.*'
02:26:05.149 [scenarios:001] ERROR i.e.activities.stdout.StdoutActivity - Unable to create a stdout statement if you have no active statements or bindings configured.

# compound tag predicate matches every assertion
[test]$ ./nb5 run driver=stdout workload=stdout-test tags='name=fox.*',unit=bravo
I'm alive!

# compound tag predicate does not fully match
[test]$ ./nb5 run driver=stdout workload=stdout-test tags='name=fox.*',unit=delta
11:02:53.490 [scenarios:001] ERROR i.e.activities.stdout.StdoutActivity - Unable to create a stdout statement if you have no active statements or bindings configured.

# any(...) form will work as long as one of the tags match
[test]$ ./nb5 run driver=stdout workload=stdout-test tags='any(name=fox.*,thisone:wontmatch)',unit=bravo
I'm alive!
```

