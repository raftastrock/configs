---
title: "Liferay"
description: "General liferay things."
layout: "guide"
icon: "code-file"
weight: 3
url: "Liferay"
---

###### {$page.description}

<article id="1">

## Integrating Metal in the Liferay context

> It is recommended to integrate metal at the *OSGI* level although you could do it from a theme level and potentially a web content level

* In relation to that keep an eye on **page fragments** that Jorge Ferrer is working on which may facilitate this

* **Loop Faro** are good examples for microsites
* Metal is only really helpful when you have **dynamic content**
  * For static content it is not useful

* Soy is only possibly on **server side**; better for **SEO**
  * At this point it is not ideal to render JSX on Java server or have like Node servlets rendering and passing it on to Java

* Talk to Travis about **workspaces**
* Use **generator cli** rather than building things out in Liferay context

</article>
