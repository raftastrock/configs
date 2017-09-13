# Block Scope

> Block scopes have curly braces

* Kyle Simpson recommends using `var` most of the time, then `let`, then `const`
  * He doesn't use `const` to declare functions only uses `const` for immutable objects

* **const** implies a constant
  * means it never is reassigned
  * the problem of using const is that it confuses readers because a lot of people still think that a "constant" doesn't change

```js
function diff(x,y) {
  if (x > y) {
    let tmp = x 
    x = y
    y = tmp
  }

  return y - x
}
```

* Let is blocked scoped to `if`
  * If you try to acces `tmp` outside of the if block you will get a *reference error*

* `let` is always better used in a `for loop`
* `let` cannot be redeclared but `var` can be redeclared

```js
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

> **Pro Tip**  If you cannot see the variable on the same page, "redeclare it" so the reader knows exactly what scope it belongs to
