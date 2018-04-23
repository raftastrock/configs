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

</article>
