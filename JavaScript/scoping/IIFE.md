# IIFE (immediately invoked function expression) Pattern

> If you don't want to pollute the name space, but you want to create scope and you only want your function to run once, the IIFE pattern is helpful

* This is similar to block scoping

```js
var foo = 'foo'

(function IIFE(bar) {
  var foo = 'foo2'
  console.log(foo) // 'foo2'
})(foo)

console.log(foo) // 'foo'
```
