---
title: "Data Structures"
description: "Computer science data structure interfaces"
layout: "guide"
weight: 2
---

###### {$page.description}

<article id="1">

## Sets

* A set is like an amorphous cloud

```javascript
set.add(5)
	.add(7)
	.add(7)
```
* Only 5 and 7 will be added once

</article>


<article id="2">

## Stacks & Queues

### Stacks

![stack](https://www.tutorialspoint.com/data_structures_algorithms/images/stack_representation.jpg)

* *LIFO*: The **Last** item added **Into** the stack will be the **First** one taken **Out** of the stack
	* The idea of the "call stack" goes along with this concept

#### Interface:

##### Constructor Function

* **Storage**: using a string instead of an array so we can feel what it is like to build in that functionality ;)

##### Methods

```javascript
push(value) // adds value to the front & returns size of stack
pop() //removes value from front, returns value
size() //returns size of stack as an integer
```

#### Implementation
<p data-height="300" data-theme-id="31719" data-slug-hash="vWLpYe" data-default-tab="js" data-user="RyanGarant" data-embed-version="2" data-pen-title="Stack" class="codepen">See the Pen <a href="https://codepen.io/RyanGarant/pen/vWLpYe/">Stack</a> by Ryan Garant (<a href="https://codepen.io/RyanGarant">@RyanGarant</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

```javascript

const Stack = function() {
	this.storage = ''
}

Stack.prototype.push = function(val) {
	this.storage = `${this.storage},${val}`
}

Stack.prototype.pop = function() {
  const lastValIndex = this.storage.lastIndexOf(',')
  this.storage = this.storage.substring(0, lastValIndex)
}

Stack.prototype.size = function() {
  console.log((this.storage.match(/,/g) || []).length)
}

const myWeeklyMenu = new Stack()

myWeeklyMenu.push('redBeans')
myWeeklyMenu.push('blueBeans')
myWeeklyMenu.push('yellowBeans')

myWeeklyMenu.pop()

myWeeklyMenu.size()

console.log(myWeeklyMenu.storage)

```

## Queues

* FIFO

<img src="/images/queues.png" alt="Queues">

<p data-height="300" data-theme-id="31719" data-slug-hash="wPEyRg" data-default-tab="js" data-user="RyanGarant" data-embed-version="2" data-pen-title="Queue Data Structure" class="codepen">See the Pen <a href="https://codepen.io/RyanGarant/pen/wPEyRg/">Queue Data Structure</a> by Ryan Garant (<a href="https://codepen.io/RyanGarant">@RyanGarant</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>
</article>
