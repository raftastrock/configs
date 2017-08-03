# Iteration

## Bubble Sort

> bigO = n ^ 2

```js
function bubbleSort(nums) {  
  do {
    var swapped = false
    
    for (let i = 0; i < nums.length; i++) {
      if (nums[i] > nums[i + 1] {
        const temp = nums[i]
        nums[i] = nums[i + 1]
        nums[i + 1] = temp
        swapped = true
      }
    }
  } while(swapped)
}
```

* You probably will never use a do loop or bubble sort in production code


## Insertion Sort

> bigO = n ^ 2

* Has more favorable coefficients than bubble sort

