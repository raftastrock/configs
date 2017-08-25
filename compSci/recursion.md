# Recursion

> Your **base case** is the most important piece.  If you don't write this first you will stack overflow


```js
function basicRecursion(max, current) {
  if (current > max) return
  console.log(current)
  basicRecursion(max, current + 1)
}

basicRecursion(1, 10)
```


## Fibonacci Sequences

> 1, 1, 2, 3, 5, 10

* Fibonacci sequences lends itself well to recursion because they are themselves defined **recursively**
  * You need to know the **first two preceeding** terms to get the nth number of the sequence

```js
function fibonacci(n) {
  if (n <= 2) return 1
  
  return fibonacci(n - 1) + fibonacci(n - 2)
}
```

## Factorials

> !4 = 4 * 3 * 2 * 1

* Factorials are defined recursively by **multiplying itself** by the previous number until you get to 1

```js
function factorial(n) {
  if (n < 2) return 1
  
  return n * function factorial(n) {
  if (n < 2) return 1
  
  return n * factorial(n - 1)
}
```

## Merge Sort

> bigO = O(n log n)

* Recursive algo that is very **stable**
  * However when sorting numbers stability doesn't matter because you don't care what order two 4's for instance are given to you
