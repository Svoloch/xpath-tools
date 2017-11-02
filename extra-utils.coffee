
"""
a abbr acronym address applet area article aside audio
b base basefont bdi bdo bgsound big blink blockquote body br button
canvas caption center cite code col colgroup command comment
datalist dd del details dfn dir div dl dt em embed
fieldset figcaption figure font footer form frame frameset
h1 h2 h3 h4 h5 h6 head header hgroup hr html
i iframe img input ins isindex kbd keygen label legend li link listing
main map mark marquee menu meta meter multicol
nav nobr noembed noframes noscript object ol optgroup option output
p param plaintext pre progress q rp rt ruby
s samp script section select small source spacer span strike strong style sub summary sup
table tbody td textarea tfoot th thead time title tr track tt u ul var video wbr xmp
""".split(/\s+/).forEach (name)->
	$html[name] = (args...)->
		tag = $html tag
		for arg in args
			if typeof arg == 'string'
				tag.address arg
			else if typeof arg == 'object'
				tag.attr args
			else if tag.constructor.XPath.defaults.strict
				throw new TypeError "Wrong type of parameter"
		tag
"""
a altGlyph altGlyphDef altGlyphItem animate animateColor animateMotion animateTransform
circle clipPath color-profile cursor defs desc ellipse
feBlend feColorMatrix feComponentTransfer feComposite feConvolveMatrix
feDiffuseLighting feDisplacementMap feDistantLight feFlood feFuncA feFuncB feFuncG feFuncR
feGaussianBlur feImage feMerge feMergeNode feMorphology feOffset
fePointLight feSpecularLighting feSpotLight feTile feTurbulence
filter font font-face font-face-format font-face-name font-face-src font-face-uri foreignObject
g glyph glyphRef hkern image line linearGradient marker mask metadata missing-glyph mpath
path pattern polygon polyline radialGradient rect script set stop style svg switch symbol
text textPath title tref tspan use view vkern
""".split(/\s+/).forEach (name)->
	$svg[name] = (args...)->
		tag = $svg tag
		for arg in args
			if typeof arg == 'string'
				tag.address arg
			else if typeof arg == 'object'
				tag.attr args
			else if tag.constructor.XPath.defaults.strict
				throw new TypeError "Wrong type of parameter"
		tag
