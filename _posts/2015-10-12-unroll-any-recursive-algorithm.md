---
title: "Generic process to unroll any recursive algorithm"
tags:
  - how-to
  - technical
  - youhearditherefirst
old-link: https://fulldecent.blogspot.com/2015/10/generic-process-to-unroll-any-recursive.html
---

In computer programming, you run into recursive algorithms when dealing with a problem that exhibits similar substructure. Recursion will apply the exact algorithm to a subset of the problem and then combine the result in some way with the remainder of the problem. Using recursion can be very readable and elegant. You are not likely to come across a contrived usage of a recursive algorithm.

{: .margin-note}
Of course, because the computer itself runs code in a linear sequence.

Recursion uses a finite resource, stack space, and requires an assumption that the algorithm—with expected inputs—will not exhaust this resource. If this assumptions fails, then you will need to "unroll" the algorithm to make it not recursive, or reconsider your approach altogether. <mark>It is always possible to rewrite a recursive algorithm as unrolled</mark>.

Here I will demonstrate a *generic* way to unroll any recursive algorithm. Of course, for your specific algorithm, you can surely do better.

Our example is finding tree depth, [from Eric Lippert](<https://blogs.msdn.com/b/ericlippert/archive/2005/08/01/recursion-part-two-unrolling-a-recursive-function-with-an-explicit-stack.aspx> at Microsoft:

```c
int depth(node *tree) {
  if (!tree)
    return 0;
  return 1 + MAX(depth(tree->left), depth(tree->right));
}
```

And this recursive implementation is vulnerable to a stack overflow. If the input is a maximally lobsided tree, this will use stack space linear with the tree storage.

## Step one

Refactor your code to meet a few requirements:

1. All variables must be defined, without initialization, at the top of the function
2. Each recursion must be on its own line
3. Use a `retval` variable

```c
int depth1(node *tree) {
  int retval;
  int l;
  int r;
  if (!tree) {
    retval = 0;
    return retval;
  }
  l = depth(tree->left);
  r = depth(tree->right);
  retval = 1 + (l > r ? l : r);
  return retval;
}
```

## Step two

Create a `stack` struct and move all variables there. Also include a parent pointer, a `resume_point` int, a `retval`, a `returned_val` and any function parameters. In the function, make a pointer to this stack entry and use the variables from there. Also initialize `parent = NULL`.

```c
 typedef struct depth_stack {
  int l;
  int r;
  node *tree;
  int resume_point;
  struct depth_stack *parent;
  int retval;
  int returned_val;
} depth_stack;

int depth2(node *tree) {
  depth_stack *pStack = malloc(sizeof(depth_stack));
  pStack->parent = NULL;
  pStack->tree = tree;

  if (!pStack->tree) {
    pStack->retval = 0;
    return pStack->retval;
  }
  pStack->l = depth(pStack->tree->left);
  pStack->r = depth(pStack->tree->right);
  pStack->retval = 1 + (pStack->l > pStack->r ? pStack->l : pStack->r);
  return pStack->retval;
}
```

## Step three

Add a new variable `tmp_stack` for your opening variables, then push that into your stack. Replace each recursion call with code to push on the stack. At the end, include code for returns that pops the stack and returns if empty. When pushing and popping, use a unique `resume_point` and `goto` ([yes, really](https://xkcd.com/292/)) to get back to that location.

```c

int depth3(node *tree) {
  depth_stack *tmp_stack = malloc(sizeof(depth_stack));
  tmp_stack->tree = tree;
  depth_stack *pStack = NULL;

push:
  tmp_stack->parent = pStack;
  pStack = tmp_stack;
  if (!pStack->tree) {
    pStack->retval = 0;
    goto pop;
  }

  // Recurse left call
  pStack->resume_point = 1; // will pick up back here
  tmp_stack = malloc(sizeof(depth_stack));
  *tmp_stack = *pStack;
  tmp_stack->tree = pStack->tree->left;
  goto push;
recur1done:
  pStack->l = pStack->returned_val;

  // Recurse right call
  pStack->resume_point = 2; // will pick up back here
  tmp_stack = malloc(sizeof(depth_stack));
  *tmp_stack = *pStack;
  tmp_stack->tree = pStack->tree->right;
  goto push;
recur2done:
  pStack->r = pStack->returned_val;

  pStack->retval = 1 + (pStack->l > pStack->r ? pStack->l : pStack->r);
  goto pop;

pop:
  if (pStack->parent) {
    tmp_stack = pStack;
    pStack = tmp_stack->parent;
    pStack->returned_val = tmp_stack->retval;
    free(tmp_stack);
    if (pStack->resume_point == 1) goto recur1done;
    if (pStack->resume_point == 2) goto recur2done;
  }
  return pStack->retval;
}
```

## Conclusion

In step 3 we have implemented a deterministic way to translate a recursive functions to an unrolled one. Therefore, this exact technique applies to every recursive function. Of course in the real world you will probably find a better control flow than `goto`, but I hope this is a helpful starting point.

[Full code Gist](https://gist.github.com/fulldecent/45313d847aca8d6b6ba3)
