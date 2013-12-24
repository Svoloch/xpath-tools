
$X = do->
	class Class extends Array
		constructor: -> super()
		clone: ->
			result = new @.constructor
			result.push.apply result, @
			result
		xpath: (xp)->
			result = new @.constructor
			for element in @
				result.push.apply result, XPath xp, element
			result
		unique: if typeof Set == 'function'
			->
				result = new @.constructor
				set = new Set
				for item in @ then unless set.has item
					set.add item
					result.push item
				result
		else
			->
				result = new @.constructor
				for item in @ then if ~(result.indexOf item)
					result.push item
				result
		on: (event, callback)->
			for item in @
				try
					item.addEventListener event, callback, false
				catch e then
			@
		off: (event, callback)->
			for item in @
				try
					item.removeEventListener event, callback, false
				catch e then
			@
		one: (event, callback)->
			oneCallback = ->
				try
					@removeEventListener event, oneCallback, false
				catch e then
				callback.apply @, arguments
			for item in @
				try
					item.addEventListener event, oneCallback, false
				catch e then
			@
		once: (event, callback)->
			copy = @clone()
			onceCallback = ->
				try
					for item in copy
						item.removeEventListener event, onceCallback, false
				catch e then
				callback.apply @, arguments
			for item in @
				try
					item.addEventListener event, onceCallback, false
				catch e then
			@
		addClass: (cls)->
			for item in @ when item instanceof Element
				item.setAttribute 'class', if item.hasAttribute 'class'
					classValue = item.getAttribute 'class'
					if ~((classValue.split /\s+/).indexOf cls)
						classValue
					else
						"#{classValue} #{cls}"
				else cls
			@
		removeClass: (cls)->
			test = (className)->className!=cls
			for item in @ when item instanceof Element
				if newClass = item.getAttribute('class').split(/\s+/).filter(test).join(' ')
					item.setAttribute 'class', newClass
				else item.removeAttribute 'class'
			@
		attr: (attrs)->
			for item in @ when item instanceof Element
				for name,value of attrs
					try
						item.setAttribute name, value
					catch e then
			@
		css: (attrs)->
			for item in @ when item instanceof Element
				for name,value of attrs
					item.style[name] = value
			@
		empty: ->
			for item in @ when item instanceof Element
				while item.hasChildNodes()
					item.removeChild item.firstChild
			@
	XPath = (xpath, root = document.documentElement)->
		iterator = try
			document.evaluate xpath, root
		catch e then
		result = new Class
		if iterator
			while (item = iterator.iterateNext())?
				result.push item
		result
	XPath.Class = Class
	XPath
$A = (arr)->
	result = new $X.Class
	result.push.apply result, arr
	result
$svg = (tag)->	$A [document.createElementNS "http://www.w3.org/2000/svg", tag]
$html = (tag)-> $A  [document.createElementNS "http://www.w3.org/1999/xhtml", tag]
$ID = (id)-> $A [document.getElementById id]
$C = (cls)->	$A document.getElementsByClassName cls
$N = (name, root)-> $X "//*[@name=#{JSON.stringify name}]", root
$L = console.log.bind console
