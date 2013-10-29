--- 
layout: post
title: "Whats all the fuss about"
author: "Scott"
comments: true
---

Welcome to the project, so your likely to want to know what this is all about.

Where do we begine, I suppose I should give you an overview of what Theseus is. 

Theseus is a screen/document scraping/processing engine that is designed to allow you to write applications,
against our native .net library or via our JavaScript[^2] runtime, to request webpages, process JSON
APIs, or download and process Excel/CSV[^1] documents all from the web[^3].

[^1]: This support is for .xls, .xlsx, and .csv formats.

[^2]: Initally we will be supporting writing scripts in both JavaScript and CoffeeScript but hope to support 
      other lnaguage that compile down to native JavaScript i.e. TypeScript.

[^3]: We expose a virtual web browser, so even if the website you wish to access is behind login screen that uses cookie authentication then 
      we still have you covered.
      


###Part 1.. the core.

Firstly there is the open source (or soon to be) Theseus engine.

The Theseus Engine is made up of 3 main components;

1. The core engine, this is the virtual web browser, responsible for keep state between requests, 
   and processing the different types of documents back into a common interface, so if you first 
   request a web page, then move onto downloading an Excel report the core will make t so you shoudn't
   need to know the differences of the formats[^4].
2. The JavaScript runtime, this allows you to run a script[^5], with access to the core virtual web browser, and have it return an `Object` back[^6].
3. Finaly the Command Line runner, this is a wrapper around the JavaScript runtime that lets you run your scripts and returns JSON documents back as output.

[^4]: The only exception is the query API, the query syntax is based on the common sytax of the relavent underlying content type, e.g. you will use CSS selectors when trying to extract content form HTML, but for extracting infor form XML it XPath, or it the Excel Cell lookup syntax (i.e. `A4:B7`).
[^5]: you can also create script across multiple files and include them backtogether using the CommonJS Module syntaxt, this supports mixing script languages, for example you could require a *.coffee script file into a *.js script file.
[^6]: We support you getting back anu POCO object that can be deserialized via the JSON.Net library.

###Part 2.. the platform

Secondly we are planning a cloud hosting platform for your Theseus scripts, the platform will support all the
features of the command line app so you will be easly be able to develop and test your scripts locally before 
uploading them to be hosted in the cloud.

The platform will have the option for you to share your scripts for anyone to use or copy... or for a fee we 
will support private repositories, for those more sensative scripts.