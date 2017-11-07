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
	* We start with Clay Base when we generate a theme

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

* What has changed in DXP on the front end?
	* Liferay theme generator
	* Themelets
		* mini UI components
	* [Bourbon](http://bourbon.io/) sass utils
		* Process css3 features
		* provides mixins
	* Theme Contributors
		* allows you to override things like the nav
	* Importing Resources
		* Resources importer allows you to deploy theme with predefined content

This command will generate the base theme into your CWD

```shell
yo liferay-theme
```

* Verify that it your theme folder is located in `portal-folder/modules/apps`
	* Then run:

```shell
gulp deploy
```

* Then you can go to `localhost` and check
	* Other gulp tasks are available [here](https://github.com/liferay/liferay-theme-tasks)
	* Then change to your theme by clicking configure like below

<img src="/images/set-theme.png" alt="Set Theme">

</article>

<article id="3">

## Using the Build Folder

* You can pull in resources from the **build** folder
	* There are a lot of *good examples* in there all the way from templates to sass modules that will serve as a helpful guide
	* So let's saty you want a **component**, go into `build` and copy that component into `src dir`
		* Make sure to ***mirror folder structure***

</article>

<article id="4">

## Templates

### Macros

* [Here is the list of available freemarker macros](https://dev.liferay.com/develop/tutorials/-/knowledge_base/7-0/freemarker-macros#product-macros) that you can use out of the box

* Example of navigation macro

```html
<@liferay.navigation_menu
	instance_id="footer_navigation_menu"
	default_preferences="${freeMarkerPortletPreferences}"
/>
```
</article>
