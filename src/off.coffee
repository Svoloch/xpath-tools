export default do->###!IMPORT###
do do(XPath = window.$X)->###!SCRIPT###
	eventKey = Symbol()
	(XPath)->
		lastAdd = XPath.Class::addListener
		lastRemove = XPath.Class::removeListener
		add = (element, event, callback)->
			element[eventKey] ?= {}
			element[eventKey].events ?= {}
			element[eventKey].eventsDeleted ?= {}
			element[eventKey].events[event] ?= []
			element[eventKey].eventsDeleted[event] ?= 0
			element[eventKey].events[event].push callback
		add_ = (element, event, callback)->
			element[eventKey] ?= {}
			element[eventKey] ?= []
			element[eventKey].push callback
		remove = (element, event, callback)->
			if element[eventKey]?[event]?
				callbacks = element[eventKey][event]
				if deletes > 16 && deletes*2 > callbacks.length
					element[eventKey].events[event] = callbacks.filter (x)->x
					element[eventKey].eventsDeleted[event] = 0
		removeAllListeners = (event)->
			@forEach (element)->try
				if element?[eventKey]?.events?[event]?
					element[eventKey].events[event].forEach (callback)->
						lastRemove.call [element], event, callback
					element[eventKey].events[event] = []
					element[eventKey].eventsDeleted[event] = 0
		XPath.Class::addListener = (event, callback)->
			for element in @
				add element, event, callback
			lastAdd.call @, event, callback
		XPath.Class::removeListener = (event, callback)->
			if arguments.length > 1
				for element in @
					remove element, event, callback
				lastRemove.call @, event, callback
			else removeAllListeners.call @, event
			@
