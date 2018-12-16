
$A = do->
	isArray = (a)->
		(a instanceof [].constructor) || (
			(typeof a != 'string') &&
			!(a instanceof ''.constructor) && (
				try
					[].slice.call(a,0).length == a.length
				catch
					false
			)
		)
	(arr...)->
		result = new $X.Class
		for val in arr
			continue unless val?
			if isArray val
				for subval in val
					result.push ($A subval)...
			else result.push val
		result
$svg = (tag)-> $A document.createElementNS "http://www.w3.org/2000/svg", tag
$html = (tag)-> $A document.createElementNS "http://www.w3.org/1999/xhtml", tag
$ID = (id, root=document)->
	element = try
		root.getElementById id
	catch e then null
	result = new $X.Class
	if element? then result.push element
	result
$C = (cls, root=document)-> $A (root.getElementsByClassName cls)...
$N = (name, root)-> $X "//*[@name=#{JSON.stringify name}]", root
$L = console.log.bind console

$R = do->
	list = []
	(callback)->
		unless document.readyState == "complete"
			$A(document).on 'DOMContentLoaded', -> do callback
		else
			if list.length
				list.push callback
			else
				list.push callback
				while list.length
					try
						do list[0]
					catch e
						setTimeout (->throw e), 0
					finally
						list.shift()

"concat slice splice map filter".split(" ").forEach (name)->
	$X.Class::[name] = do(method=$X.Class::[name])-> ->
		result = new @constructor
		result.push.apply result, method.apply @, arguments
		result
