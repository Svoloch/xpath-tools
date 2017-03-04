
$X = do->
	defaults =
		ns:
			svg: "http://www.w3.org/2000/svg"
			html: "http://www.w3.org/1999/xhtml"
			xul: "http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul"
			xslt: "http://www.w3.org/1999/XSL/Transform"
			fo: "http://www.w3.org/1999/XSL/Format"
			xlink: "http://www.w3.org/1999/xlink"
		resolver: (ns)->(prefix)-> ns[prefix] or null
		type: 0
	class Class extends [].constructor
		constructor: -> super
		clone: ->
			result = new @constructor
			result.push.apply result, @
			result
		xpath: (xp, config)->
			result = new @constructor
			for element in @
				result.push.apply result, @constructor.XPath xp, element, config
			result
		xpathFilter: (xp)->
			result = new @constructor
			result.push.apply result, @filter (item)=>
				(@constructor.XPath xp, item, {type:3})[0]
			result
		unique: if typeof Set == 'function'
			->
				result = new @constructor
				set = new Set
				@forEach (item)-> unless set.has item
					set.add item
					result.push item
				result
		else
			->
				result = new @constructor
				@forEach (item)-> if item not in result
					result.push item
				result
		addListener: (event, callback)->
			for item in @
				try item.addEventListener event, callback, false
			@
		removeListener: (event, callback)->
			for item in @
				try item.removeEventListener event, callback, false
			@
		on: ->@addListener.apply @, arguments
		off: ->@removeListener.apply @, arguments
		one: (event, callback)->
			oneCallback = ->
				try @removeEventListener event, oneCallback, false
				callback.apply @, arguments
			for item in @
				try item.addEventListener event, oneCallback, false
			@
		once: (event, callback)->
			copy = @clone()
			onceCallback = ->
				try for item in copy
					item.removeEventListener event, onceCallback, false
				callback.apply @, arguments
			for item in @
				try item.addEventListener event, onceCallback, false
			@
		dispatch: (name, params={})->
			for element in @ when typeof element.dispatchEvent == 'function'
				event = document.createEvent 'Events'
				for key, value of params
					event[key] = value
				element.dispatchEvent event
		fire: -> @dispatch.apply @, arguments
		addClass: (cls)->
			for item in @ when item instanceof Element
				item.setAttribute 'class', if item.hasAttribute 'class'
					classValue = item.getAttribute 'class'
					if cls in classValue.split /\s+/
						classValue
					else
						"#{classValue} #{cls}"
				else cls
			@
		removeClass: (cls)->
			test = (className)-> className != cls
			for item in @ when item instanceof Element
				if newClass = item.getAttribute('class').split(/\s+/).filter(test).join(' ')
					item.setAttribute 'class', newClass
				else item.removeAttribute 'class'
			@
		attr: (attrs)->
			for item in @ when item instanceof Element
				for name, value of attrs
					splited = name.split ':'
					if splited.length == 2
						[ns, name] = splited
						ns = @constructor.XPath.defaults.ns[ns]
						try
							if value?
								item.setAttributeNS ns, name, value
							else
								item.removeAttributeNS ns, name
					else
						try
							if value?
								item.setAttribute name, value
							else
								item.removeAttribute name
			@
		getAttr: (attr)->
			(@constructor.XPath "@#{attr}", @[0], {type:2})[0]
		css: (attrs)->
			for item in @ when item instanceof Element
				for name, value of attrs
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
		val: (value)->
			if arguments.length
				for item in @ when item instanceof Element
					item.value = value
					switch
						when item instanceof HTMLTextAreaElement
							item.value = value
						when item instanceof HTMLSelectElement
							item.value = value
						when item instanceof HTMLInputElement
							switch item.getAttribute
								when 'file' then continue
								when 'checkbox', 'radio'
									item.checked = !!value
								else item.value = value
				return @
			else
				for item in @ when item instanceof Element
					switch
						when item instanceof HTMLTextAreaElement
							return item.value
						when item instanceof HTMLSelectElement
							return item.value
						when item instanceof HTMLInputElement
							switch item.getAttribute
								when 'file'
									return item.files
								when 'checkbox', 'radio'
									return item.checked
								else return item.value
	XPath = (xpath, root = document, config)->
		resolver = (config?.resolver? or defaults.resolver) (config?.ns? or defaults.ns)
		type = if config?.type? then config.type else defaults.type
		iterator = try document.evaluate xpath, root, resolver, type, null
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
	XPath.clone = ->
		newXPath = do(originalXPath = @)->->
			originalXPath.apply @, arguments
		for field in Object.keys @
			newXPath[field] = @[field]
		newClass = class extends @Class
			constructor: ->super
		newClass.XPath = newXPath
		newXPath.Class = newClass
		newXPath
	XPath
