---
title: "Setting Up DXP Theme"
description: "How to set up Liferay theme"
layout: "guide"
weight: 2
---

<article id="1">

## Environment

* You can use yeoman [liferay theme generator](https://github.com/liferay/generator-liferay-theme) or [Blade](https://dev.liferay.com/develop/tutorials/-/knowledge_base/7-0/installing-blade-cli)

### Overview of Tools For Building User Experience

#### Lexicon

* **Lexicon** only describes a set of preset styles and classes for UI
	* While **Clay** is the actual implementation of that design language
		* Clay is not in DXP yet (currently Lexicon is the experience and implementation)
			* It is on master now though

* **Clay**
	* Extension of Bootstrap 3
	* Built with SASS
	* Consists of components like Cards and Dropdowns
	* Has reusable patterns built in
	* We start with Clay Base

#### Templates

* Web Content Templates
* Application Display Templates (how you want to display)
	* Helpful because themes don't help with layout of apps on page
* Soy/JSX Templates (In book appendix)

#### Javascript

* You can use Jquery, AlloyUI & Metal JS
	* **Alloy** is supported but not recommended for new development
	* you can use **ES6**! Wahoo!!!

</article>

<article id="2">

## Theming

* What has changed in DXP
	* Liferay theme generator
	* Themelets
	* [Bourbon](http://bourbon.io/) sass utils
		* Process css3 features
		* provides mixins
	* Theme Contributors
		* allows you to override things like the nav
	* Importing Resources
		* Resources importer allows you to deploy theme with predefined content


</article>
