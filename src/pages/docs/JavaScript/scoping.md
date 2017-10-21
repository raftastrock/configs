---
title: "Scoping"
description: "Super important concept about what level declared variables can be accessed"
layout: "guide"
weight: 1
---

###### {$page.description}

<article id="1">

## Block Scope

> Block scopes have curly braces

* Kyle Simpson recommends using `var` most of the time, then `let`, then `const`
  * He doesn't use `const` to declare functions only uses `const` for immutable objects

* **const** implies a constant
  * means it never is *reassigned*
  * the problem of using const is that it confuses readers because a lot of people still think that a "constant" doesn't change

```javascript
function diff(x,y) {
  if (x > y) {
    let tmp = x 
    x = y
    y = tmp
  }

  return y - x
}
```

* **Let** is blocked scoped to `if`
  * If you try to access `tmp` outside of the **if block** you will get a *reference error*

* `let` is always better used in a `for loop`
* `let` cannot be redeclared but `var` can be redeclared

```javascript
function repeat(fn, n) {
  var result;

  for (let i = 0; i < n; i ++) {
    result = fn( result, i)
  }

  return result
}

```

* `var` is better used when you want to stylistically signal to the reader that `result` in this case is going to be used throughout the function

```js
function lookupRecord(searchStr) {
  try {
    var id = getRecord(searchStr)
  }
  catch (err) {
    var id = -1
  }

  return id
}
```

* By using `var` here you escape the block scope and can reference the variable

</article>


<article id="2">

## Function Scoping

```javascript
var foo = 'foo'

function bob(0 {
  var foo = 'foo2'
  console.log(foo) // 'foo2'
})
bob()

console.log(foo) // 'foo' phew!
```

</article>


<article id="3">

## IIFE (immediately invoked function expression) Pattern

> If you don't want to pollute the name space, but you want to **create scope and you only want your function to run once**, the IIFE pattern is helpful

* This is similar to **block scoping**

```javascript
var foo = 'foo'

(function IIFE(bar) {
  var foo = 'foo2'
  console.log(foo) // 'foo2'
})(foo)

console.log(foo) // 'foo'
```

</article>

