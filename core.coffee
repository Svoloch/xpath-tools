
$X = do->
	defaults =
		ns:
			svg: "http://www.w3.org/2000/svg"
			html: "http://www.w3.org/1999/xhtml"
			xul: "http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul"
			xslt: "http://www.w3.org/1999/XSL/Transform"
			fo: "http://www.w3.org/1999/XSL/Format"
		resolver: (ns)->(prefix)-> ns[prefix] or null
		type: 0
	class Class extends Array
		constructor: -> super()
		clone: ->
			result = new @.constructor
			result.push.apply result, @
			result
		xpath: (xp, config)->
			result = new @.constructor
			for element in @
				result.push.apply result, @.constructor.XPath xp, element, config
			result
		xpathFilter: (xp)->
			result = new @.constructor
			result.push.apply result, @.filter (item)->
				(@.constructor.XPath xp, item, {type:3})[0]
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
		remove: ->
			for item in @ when item instanceof Node
				if item.parentNode instanceof Node
					item.parentNode.removeChild item
		prepend: (args...)->
			return @ unless args.length
			prependArrayMain = (arr)->
				for value, index in arr by -1
					if value instanceof Node
						element.insertBefore value, element.firstChild
					else if value instanceof [].constructor
						prependArray value
					else
						element.insertBefore (document.createTextNode "#{value}"), element.firstChild
			prependArray = (arr)->
				if element.firstChild
					prependArray = prependArrayMain
					prependArrayMain arr
				else if arr[arr.length-1] instanceof [].constructor
					prependArray arr[arr.length-1]
					prependArray arr[0...-1]
				else
					if arr[arr.length-1] instanceof Node
						element.appendChild arr[arr.length-1]
					else
						element.appendChild document.createTextNode "#{value}"
					prependArray = prependArrayMain
					prependArray arr[0...-1]
			for item in @
				if item instanceof Node
					element = item
					break
			if element
				prependArray args
			@
		append: (args...)->
			return @ unless args.length
			appendArray = (arr)->
				for value in arr
					if value instanceof Node
						element.appendChild value
					else if value instanceof [].constructor
						appendArray value
					else
						element.appendChild document.createTextNode "#{value}"
			for item in @
				if item instanceof Node
					element = item
					break
			if element
				appendArray args
			@
	XPath = (xpath, root = document.documentElement, config)->
		resolver = (config?.resolver? or defaults.resolver) (config?.ns? or defaults.ns)
		type = if config?.type? then config.type else defaults.type
		iterator = try
			document.evaluate xpath, root, resolver, type
		catch e then
		result = new Class
		if iterator
			switch iterator.resultType
				when 1
					result.push iterator.numberValue
				when 2
					result.push iterator.stringValue
				when 3
					result.push iterator.booleanValue
				when 4, 5
					while (item = iterator.iterateNext())?
						result.push item
				when 6, 7
					for index in [0...iterator.snapshotLength]
						result.push iterator.snapshotItem(index)
				when 8, 9
					result.push iterator.singleNodeValue
		result
	XPath.Class = Class
	Class.XPath = XPath
	XPath.defaults = defaults
	XPath
$A = (arr)->
	result = new $X.Class
	result.push.apply result, arr
	result
$svg = (tag)-> $A [document.createElementNS "http://www.w3.org/2000/svg", tag]
$html = (tag)-> $A  [document.createElementNS "http://www.w3.org/1999/xhtml", tag]
$ID = (id)-> $A [document.getElementById id]
$C = (cls)-> $A document.getElementsByClassName cls
$N = (name, root)-> $X "//*[@name=#{JSON.stringify name}]", root
$L = console.log.bind console
