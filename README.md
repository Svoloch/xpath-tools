xpath-tools
===========
Tools for sipmleify working with DOM using XPath

Before using
------------

For use run:

```
coffee -c --bare --join xpath.js core.coffee events.coffee
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
