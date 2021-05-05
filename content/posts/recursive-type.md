---
title: How to create a recursive type in ReScript
date: 2020-12-13 21:07:41
---

Use the `rec` keyword.

Example type:

```res
type rec tree<'a> =
  | Node(tree<'a>, 'a, tree<'a>)
  | Leaf('a)
```

Example usage:

```res
//      1
//     / \
//    /   \
//   2     5
//  / \   / \
// 3   4 6   7

let numbers = Node(Node(Leaf(3), 2, Leaf(4)), 1, Node(Leaf(6), 5, Leaf(7)))
```

Example functions:

```res
let isNode = tree =>
  switch tree {
  | Node(_, _, _) => true
  | Leaf(_) => false
  }

let isLeaf = tree =>
  switch tree {
  | Node(_, _, _) => false
  | Leaf(_) => true
  }
```

## Reference

How do I bind subtyping in ReScript?  
https://forum.rescript-lang.org/t/how-do-i-bind-subtyping-in-rescript/767
