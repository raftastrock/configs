---
title: "DXP Front End Golden Nuggets"
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
	* You can get access to clay by doing:

```sass
@import "aui/lexicon/atlas";
```

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
		* Bourbon is deprecating vendor prefix mixins
			* [They recommend using autoprefixer](https://github.com/thoughtbot/bourbon/issues/702)
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

```htmlmixed
<@liferay.navigation_menu
	instance_id="footer_navigation_menu"
	default_preferences="${freeMarkerPortletPreferences}"
/>
```

### Theme Settings

#### Example of getting a theme setting in freemarker

```htmlmixed
<#assign show_header_search = getterUtil.getBoolean(themeDisplay.getThemeSetting("show-header-search")) />
```
</article>

<article id="5">

## Application Decorators

### Default Options
* Barebone
* Borderless
* Decorate

#### Example of changing existing app decorators

```sass
.portlet-decorate .portlet-content {
	background: $portlet-topper-color;
	border: 1px solid #DEEEEE;
}

.portlet-barebone .portlet-content {
	padding: 0;
}
```

* Then in `liferay-look-and-feel.xml` do (na)
* **id** saves in DB and **name** shows up on platform

```xml
<portlet-decorator id="trending" name="Trending">
	<portlet-decorator-css-class>portlet-trending</portlet-decorator-css-class>
</portlet-decorator>
```

</article>


<article id="6">

## Javascript

* To get access to use es6 run this in root of your theme

```shell
npm i -S liferay-theme-es2015-hook
```

* We can require js modules like so:

```javascript
require(
	'space-theme/js/top_search.es',
	function(TopSearch) {
		new TopSearch.default();
	}
);
```

* And then do cool stuff like:

```javascript
import async from 'metal/src/async/async';
import core from 'metal/src/core';
import dom from 'metal-dom/src/dom';
import State from 'metal-state/src/State';

class MyComponent extends State {
    constructor() {
        console.log('Hello, World!');
		}
		// ...more cool stuff
}

export default MyComponent;
```

* To use metal dependencies run

```shell
npm i -save metal metal-dom metal-state
```

</article>


<article id="7">

## Layout Templates

> Controls how portlets and web content layout on the page

* If you want a custom layout, you can create these in the `layouttpl/custom` folder
	* File: `layouttpl/custom/porygon_50_50_width_limited.tpl`

```htmlmixed
<div class="columns-2 container-fluid-1280" id="main-content" role="main">
	<div class="portlet-layout row">
		<div class="col-md-6 portlet-column portlet-column-first" id="column-1">
			$processor.processColumn("column-1", "portlet-column-content portlet-column-content-first")
		</div>

		<div class="col-md-6 portlet-column portlet-column-last" id="column-2">
			$processor.processColumn("column-2", "portlet-column-content portlet-column-content-last")
		</div>
	</div>
</div>
```

* You can also add an image in that same folder that will show up on the platform (Example below)

<figure>
	<img src="/images/custom-layout.png" alt="Layout">
</figure>

* Then in `liferay-look-and-feel.xml` do

```xml
<layout-templates>
	<custom>
		<layout-template id="porygon_70_30_width_limited" name="Porygon 2 Columns (70/30) width limited">
			<template-path>/layouttpl/custom/porygon_70_30_width_limited.tpl</template-path>
			<thumbnail-path>/layouttpl/custom/porygon_70_30_width_limited.png</thumbnail-path>
		</layout-template>
	</custom>
</layout-templates>
```

</article>
