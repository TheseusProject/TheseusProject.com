---
layout : docs
title : JavaScript API
---

## Globals {#globals}

The JavaScript runtime complies with [ECMAScript Edition 5](http://www.ecmascript.org/)
We add very little to the global environment over the standards, what we do add are


### `_args` {#globals:args}

`_args` is a simple hash of key value pairs passed into the script are execution time.

#### Usage {#globals:args:usage}
    if (_args.key){
        //do something because "key" is defined   
    }

or alernatively you could access like

    if (_args["key"]){
        //do something because "key" is defined   
    }

#### Remarks {#globals:args:remarks}
For the command line interface these can be passed in on the command line as paramaters (see [Command Line API]{#commandline.html#args}), but for hosted web interfaces these are likely to be querystring paramaters.



### `require(moduleName)` {#globals:require}

`require(moduleName)` is a function used to load in user and internal modules (see [modules](#modules))

#### Paramaters
##### `moduleName`
The name of the module to load, file extensions are optional.

#### Usage {#globals:require:usage}
    
    var browser = require('browser');

or

    var myModule = require('lib/MyModule');
    
#### Remarks {#globals:args:remarks}
If there is any ambiguity about weather to load an internal module vs a user module, internal ones win, but it very easy to force theseus to treat module names as user modules all you need to do is make sure you qualify the local path i.e. instead of requesting `require('module')` use `require('.\module')` instead.



### `module` {#globals:module}

`module` has on property that it exposes, `module.exports` whatever you assign to `module.exports` will be what is returned from `require(moduleName)`.


### `exports` {#globals:module}
This is just a reference to `module.exports`.

##Modules {#modules}

Modules use the CommonJS/Node.Js module pattern. We even go as far as making your root script a module and your response being what is exported.

Modules are all singletons, i.e. no mater how meny times you call `require` in which ever script file then you will allways be retuend the exact same instance of a module, so any state is retained between calls, no mater which module is calling it.
 
### User Modules

User modules are scripts in the the directory, or subdirectories, of your source folder. 
The module name that is assigned to each script is based on its relative file name to the source directory.

    Source directory
        - App.js {root application module}
        - [Lib]
            - School.js
            - List.js

Inside `App.js` you will be able to access the value `module.exports` from `[Lib]\School.js` by calling `var school = require('lib\school');` 


### Internal Modules

Internal modules are module with special permission, the more notable, and the one you will use the most is 
`browser` this is the single entry point to access theseus virtual web browser.

#### `browser`
Access by calling `require('browser')`.

this returns an instance of [`Browser`](#browser).



## Browser {#browser}

### `get(url)`

* `url` is a `string`

performs a http get request of the `url` and returns an instance of [`Resource`](#browser:resource)

### `post(url, args)`

* `url` is a `string`
* `args` is a javascript object that are to be form encoded as the postback paramaters

performs a http get request of the `url` and returns an instance of [`Resource`](#browser:resource);


### `submit(node)`

* `node` is a [`Node`](#browser:node)

Used for submitting forms from an html based [`Resource`](#browser:resource)

We take the `node` find the relevent parent form element and then perform a `GET` or `POST` request based on the forms `method` attribute.





## Resource {#browser:resource}
The resource is a single requested item, be that an HTML page, a JSON object or an Excel document, no matter what sort of resource it is the API is identical with the single exception of the Query syntax is resource type specific.

### `location`
The final URL of the requested resource after any redirects have been followed.

### `status`
The response status for the request. e.g 404, 401, 200 etc.

### `contentType`
The value of the Content-Type HTTP header for the HTTP response.

### `contentLength`
The value of the Content-Length HTTP header for the HTTP response.

### `root`
This is the root [node](#browser:node) of the request document, and the entry point for walking the node tree processing the content.

### `findAll(query)`

* `query` is a `string` (see [Query Syntax](#query))

Will search the entire resource and return an `Array` of [`Node`](#browser:node)s that match.

### `find(query)`

* `query` is a `string` (see [Query Syntax](#query))

Will search the entire resource and return the first matching [`Node`](#browser:node).





## Node {#browser:node}

### `name`
The name of the node, for example for an HTML reosurce the Name will be the Tag name.

### `text`
The textual contents of the node.

### `value`
The raw value of the node.

### `selected`
Indercates weather this node is in a selected state.

### `attr`
Is a simple object respresenting any other attributes of the node.

For example in HTML and XML this is maps directly to the Element Attributes.

### `parent()`

returns the parent [`Node`](#browser:node).

### `next()`

returns the next sibling [`Node`](#browser:node).

### `previous()`

returns the previous sibling [`Node`](#browser:node).

### `children()`

return an `Array` of children [`Node`](#browser:node)s

### `descendents()`

return an `Array` of all the descendent [`Node`](#browser:node)s

### `findAll(query)`

* `query` is a `string` (see [Query Syntax](#query))

Will search the [`Node`](#browser:node)s relative to this node and return an `Array` of [`Node`](#browser:node)s that match.

### `find(query)`

* `query` is a `string` (see [Query Syntax](#query))

Will search the [`Node`](#browser:node)s relative to this node and return the first matching [`Node`](#browser:node).





## Query Syntax {#query}
###HTML Documents
For Html Documents the we support the CSS selector query syntax.

For example to find all a tags inside the nav inside the header of a page you could use
`resource.findAll('#header nav li a')`


###Excel Documents
For Excel Documents the we support the Excel style lookups.

For example to find the cells A1, A2, B1 and B2 omn the 'SecondPage' work sheet you could use 
`resource.findAll('SecondPage!A1:B2')`

###JSON Documents
For JSON Documents the we support the object path notation.

For example if we had a JSON document as such 
    {
        name : "name",
        dob : {
            month : 02,
            day : 02,
            year : 1984
        }
    }

and you wished to access the year of birth you could use `resource.find('dob.year')`


###XML Documents
For XML Documents the we use XPath

and you wished to access the year of birth you could use `resource.find('.\dob\year')`


###CSV Documents
For CSV Documents the we use and R0C0 syntax

If you wanted to get the top 4 rows you could use `resource.findAll('R1:R4')`

now on each row you can use eather a column syntax or a header name 
for example `row.findAll(ColNameStart:ColNameEnd)` or `row.findAll(C1:C4)`