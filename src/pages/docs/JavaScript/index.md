---
title: "JavaScript"
description: "When you strive to comprehend your code, you create
better work and become better at what you do. The code isn’t just
your job anymore, it’s your craft. ~Jenn Lukas"
layout: "guide"
icon: "flash"
weight: 2
---

###### {$page.description}

<article id="1">

> I am not content, nor should you be, at stopping once something just works, and not really knowing why. I gently challenge you to journey down that bumpy "*road less traveled*" and embrace all that JavaScript is and can do. With that knowledge, no **technique**, no **framework**, no popular **buzzword** acronym of the week, will be beyond your understanding. ~Kyle Simpson

## Principles of JS

### Thread of execution
* Definition: parsing and executing the code line after line
* The thread never executes more than one line at a time
	* Hence the name *"single threaded"
* **The thread of execution** will never enter your function declaration until you call the function

#### Execution Context Example

```javascript
const num = 3;

function multiplyBy2(inputNumber) {
	const result = inputNumber * 2
	resturn result
}

const output = multiplyBy2(4)
const newOutput = multiplyBy2(10)
```

* Execution context:
	* You have a **local** and a **global** execution context
	* when you call multiplyBy2 the thread enters the function
	* comprised of **local memory**
	* assigns result to 8
	* returns result and stored in `output` global memory
	* The local execution context then goes away and the global execution context picks up at newOutput


### Call Stack

*How do you keep track of calling functions within functions?*
* The way JS keeps track of the thread of execution in all its contexts is with the call stack
* The call stack uses the **stack data structure**
	* So the last thing that you **push** on the stack, is the first thing it gets out (**LIFO**)
* Typically you have one call stack in your environment
	* Sometimes you have multiple callstacks with things like web workers

*How does it work (using the previous JS example)?*

1. **Push** global on call stack
2. **Push** multiplyBy2 on stack
3. **Pop** multiplyBy2 off stack after you get return value
4. Goes back to global execution context because that is on the top of the stack
5. **Push** the second multiplyBy2 call to the top of stack
6. **Pop** multiplyBy2 off stack after you get return value
7. Goes back to global execution context because that is on the top of the stack

* The thread is always at the top of the call stack
* And variables are always stored in which ever part of the call stack they are in

### Example of reading code line by line

```javascript
function copyArrayAndDivideBy2(array) {
	let output = []
	for (let i =0; i < array.length; i++) {
		output.push(array[i]/2)
	}
	return output
}

const myArray = [1,2,3]
let result = copyArrayAndDivideBy2(myArray)
```

Line By Line:

1. Declaring copyArrayAndDivideBy2 function & storing it's definition in global storage under the label copyArrayAndDivideBy2
2. Store an unreassignable myArray variable under the label myArray in global memory with value of an Array literal that is flat with three number values
3. Declare result as undefined in global memory
4. Push copyArrayAndDivideBy2 function call onto call stack
5. Create a new local execution context for copyArrayAndDivideBy2
6. Establish params (In this case array param = [1,2,3]) 
7. Declare a reassignable variable output in copyArrayAndDivideBy2 and assign it to an empty Array literal
7. Declare i as 0
8. Establish logic to continue the loop
9. Do math push it on output
10. Exit loop
11. return output array
12. Assign return value to result in global memory
13. pop copyArrayAndDivideBy2 off callstack

</article>

<article id="2">

## Functional Programming

* The most prominent paradigm in the past 25 years is object oriented programming
* This is an alternative paradagm

#### Classic characteristics of functional programming

* Functions are **first class citizens**
* **Pure functions**: no side effects (*you don't change/mutate your program*)
	* It's only consequence is the return value of the function
* Immutable

### Pair Programming
* A secret to growing into a junior or senior level engineer
* Hard learning is where you grow the most
* **Hard Learning Spectrum**
	1. *The Researcher Trap*
		* Doing the hard work but you just get stuck researching and never get to coding
	2. *The StackOverflow Approach*
		* Take snippet try it, it doesn't work, try another snippet......
* Pair programming solves the hard learning dilema

#### How to do it?
* **Driver**: One person is saying psuedocode  
* **Navigator**: One person is interpreting & typing psuedocode
	* The navigator never tells the driver how to turn the psuedocode into the code specifically
	* This greatly helps with technical communication


#### Generalizing Functions

Refactoring the previous example to be more DRY & General:

```javascript
function copyArrayAndManipulate(array, instructions) {
  let output = [];
  for (let i = 0; i < array.length; i++) {
    output.push(instructions(array[i]));
  }
  return;
  output;
}
function multiplyBy2(input) {
  return;
  input * 2;
}
let result = copyArrayAndManipulate([1, 2, 3], multiplyBy2);
```

#### First Class Objects:

* They can co-exist with and can be treated like any other js object
	* The only bonus thing of an object is that it can be executed/run

#### Higher Order Functions vs. Callbacks

* **HOCs** are simply functions that return other functions
* **Callbacks** are the function that is passed into the HOC
* They simplify your code and help keep it **DRY**

##### Line By Line example

```javascript
function instructionGenerator() {
	function mulitplyBy2(num) {
		return num * 2
	}

	return multiplyBy2
}

let generatedFunc = instructionGenerator()

let result = generatedFunc(3)
```

* The key line that throws seasoned devs off is `let generatedFunc = instructionGenerator()`
	* Because instruction generator doesn't actually call multiplyBy2, it returns the function definition of multiplyBy2 

</article>

<article id="3">

## Closure

### The power of closure:

* Our functions get '**memories**'
	* **once**
		* You can "onceify" your function so that it can only be run once
	* **memoize**
		* Say you have an algo that requries lots of steps like getting the 1000th prime number
		* You can save that value "memoize" in the function's backpack like
```javascript
const primeNumbers = { 1000: x }
```
		* So next time you look for > than the 1000th prime number
* The functions get live persistent memeory
* We can implement the JS module pattern

* When function is called a **live store** is created which includes:
	* local memory
	* variable environment (VE)
	* state

* When function is finished executing it **deletes local memory** automatically
	* The exception is for returned value
	* This is known as *garbage collection*


#### So why wouldn't you just use global memory?

* Problems with that:
	* Often times you want independent live stores associated with each function rather than one big global store
	* When you write code at scale you do not want to pollute global memory
		* If you are adding things to the global scope and you are working with hundreds of other engineers who try to use the same name, you will have name collisions
	* You can't use the module pattern
		* where you write code in such away that its data sticks around but is protected
			* You also should try to make your functions easy to write to and easy to get data out of

##### Line By Line example

<p data-height="300" data-theme-id="31719" data-slug-hash="PeWzMQ" data-default-tab="js,result" data-user="RyanGarant" data-embed-version="2" data-pen-title="JS Closure Example" class="codepen">See the Pen <a href="https://codepen.io/RyanGarant/pen/PeWzMQ/">JS Closure Example</a> by Ryan Garant (<a href="https://codepen.io/RyanGarant">@RyanGarant</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>

* Given everything we currently know, when you call `myNewFunction` you would not expect it to be able to find the variable `counter` because that has been garbage collected when we finished calling `outer()`
	* **HUGE POINT**: However at the time of function declaration, it stores in its def the surrounding data
		* In this case the `counter` var

* When we store the function definition of `incrementCounter` in the variable `myNewFunction` it carries on its back a **"backpack"** which is in this case the **live persistent variable** `counter`
	* This is a beautiful concept because it provides a way to have **live persistent data between function calls**
	* The **backpack** is also known as:
		* **closure** (most colloquial but not very helpful)
		* **lexical scope**
			* This is what we mean when JS is statically or lexically scoped
		* **closed over variable environment (COVE)**
	* This backpack is stored behind the scenes in the function definition as `[[scope]]`
		* So how can you access this data?
			* It's only available from the call of this function
			* And only the data that is referenced within `incrementCounter` is going to be stored in the backpack
				* If there were other variables besides `counter` defined outside `incrementCounter` they would be garbage collected
 
</article>
