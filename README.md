xpath-tools
===========
Tools for simpleify working with DOM using XPath

Before using
------------

For use run:

```
coffee -c --bare --join xpath.js core.coffee utils.coffee events.coffee
```

Then you can attach `xpath.js` to HTML, SVG or other file by `<script/>` tag.

How to use
----------

`$X` is the main function.

`$X("//input[@type='number']")`
selet all input elements with number type.

`$X("//table").xpath("count(tr|tbody/tr)")`
numbers of rows in each table in document.

`$C("cls").xpathFilter("img")`
elements with class `cls` and having image inside.

`core.coffee`
-------------

Main code.

`$X(xpath, root, config)` apply `xpath` as XPath to `root` element with options passed by `config` and return array like object with selection result.
* `xpath` - XPath string
* `root` - XML element or document, `document` by default
* `config` - object with options, only `type` using. `type` passed to native XPath selector, 0 by default

`$X.Class` - constructor of objects used in this library, extends `Array`.

`$X.Class::clone` - return object with same content.

`$X.Class::xpath(xpath, config)` - apply `xpath` to each element in current object.

`$X.Class::xpathFilter(xpath)` - filtering elements by `xpath`.

`$X.Class::unique()` - elements included in result only once.

`$X.Class::addListener(event, callback)` - set `callback` to `event` for all elements.

`$X.Class::removeListener(event, callback)` - unset `callback` from `event` for all elements.

`$X.Class::on(event, callback)` - link to `$X.Class.addListener`.

`$X.Class::off(event, callback)` - link to `$X.Class.removeListener`.

`$X.Class::one(event, callback)` - `callback` executed once for each element.

`$X.Class::once(event, callback)` - `callback` executed once.

`$X.Class::dispatch(name, params)` - call event named `name` with parameters in `params`.

`$X.Class::fire(name, params)` - link to `$X.Class.dispatch`.

`$X.Class::addClass(cls)` - 

`$X.Class::removeClass(cls)` -

`$X.Class::attr(attrs)` - set attributes from object `attrs`. `null` and `undefined` values removes attribute.

`$X.Class::getAttr(attr)` - return value of first attribute named `attr` of elements in object.

`$X.Class::css(styles)` - set styles from `styles`.

`$X.Class::empty()` -

`$X.Class::remove()` -

`$X.Class::prepend()` -

`$X.Class::append()` -

`$X.Class::replace()` -

`$X.Class::replaceContent()` -

`$X.Class::getFirstNode()` - first node in container, not in DOM.

`$X.Class::val()` - get value from first input HTML element.

`$X.Class::val(value)` - set first HTML input element to `value`.

`$X.clone()` - get clone of `$X`, useful if you use different code with using this library.

`$X.defaults` - object for configurating of library.

`$X.defaults.ns` - short namespace used in XPath.

`off.coffee`
------------

Patch `$X.Class::addListener` and `$X.Class::removeListener`

`$X.Class::removeListener(event)` - unset all callbacks from `event` for all elements.

`events.coffee`
---------------

You can use event name as method for set callback.

`iepatch.coffee`
----------------

For Internet Exploer with version less then 7.

`utils.coffee`
--------------

`$R(callback)` - execute `callback` after document is ready.

`$A(arr...)` - return object with elements from `arr`.
Arrays and subarrays from `arr` added as all elements from them.

`$ID(id)` - select element by id.

`$C(cls)` - select elements by class.

`$N(name)` - select elements by name.

`$html(tag)` - create HTML element.

`$svg(tag)` - create SVG tag.

`$X.Class::concat`, `$X.Class::slice`, `$X.Class::splice`, `$X.Class::map`, `$X.Class::filter` - return `$X.Class` value.

`$L` - output data to console.

