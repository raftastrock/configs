# Function Scoping

```js
var foo = 'foo'

function bob(0 {
  var foo = 'foo2'
  console.log(foo) // 'foo2'
})
bob()

console.log(foo) // 'foo' phew!
```
