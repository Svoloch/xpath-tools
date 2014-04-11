
do(XPath = $X)->
	lastAdd = XPath.Class::addListener
	lastRemove = XPath.Class::removeListener
	add = (element, event, callback)->
		element.__xpathinfo__ ?= {}
		element.__xpathinfo__.events ?= {}
		element.__xpathinfo__.eventsDeleted ?= {}
		element.__xpathinfo__.events[event] ?= []
		element.__xpathinfo__.eventsDeleted[event] ?= 0
		element.__xpathinfo__.events[event].push callback
	remove = (element, event, callback)->
		if element?.__xpathinfo__?.events?[event]?
			callbacks = element.__xpathinfo__.events[event]
			deletes = element.__xpathinfo__.eventsDeleted[event]
			deletes += delete callbacks[callbacks.indexOf callback]
			if deletes > 16 && deletes*2 > callbacks.length
				element.__xpathinfo__.events[event] = callbacks.filter (x)->x
				element.__xpathinfo__.eventsDeleted[event] = 0
	removeAllListeners = (event)->
		@forEach (element)->try
			if element?.__xpathinfo__?.events?[event]?
				element.__xpathinfo__.events[event].forEach (callback)->
					lastOff.call [element], event, callback
				element.__xpathinfo__.events[event] = []
				element.__xpathinfo__.eventsDeleted[event] = 0
	XPath.Class::addListener = (event, callback)->
		for element in @
			add element, event, callback
		lastAdd.call @, event, callback
	XPath.Class::removeListener = (event, callback)->
		if arguments.length > 1
			lastRemove.call @, event, callback
			for element in @
				remove element, event, callback
		else removeAllListeners.call @, event
		@
