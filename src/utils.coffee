export default do->(XPath)->###!IMPORT###
do(XPath = window.$X)->###!SCRIPT###
		$L = console.log.bind console
		$A = do->
			isArray = (a)->
				(a instanceof [].constructor) || (
					(typeof a != 'string') &&
					!(a instanceof ''.constructor) &&
					!(a instanceof Node) && (
						try
							[].slice.call(a,0).length == a.length
						catch
							false
					)
				)
			(arr...)->
				result = new XPath.Class
				for val in arr
					continue unless val?
					if isArray val
						for subval in val
							result.push ($A subval)...
					else result.push val
				result
		$ID = (id, root=document)->
			element = try
				root.getElementById id
			catch e then null
			result = new XPath.Class
			if element? then result.push element
			result
		$C = (cls, root=document)-> $A (root.getElementsByClassName cls)...
		$N = (name, root)-> XPath "//*[@name=#{JSON.stringify name}]", root
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
		$svg = (tag)-> $A document.createElementNS "http://www.w3.org/2000/svg", tag
		$html = (tag)-> $A document.createElementNS "http://www.w3.org/1999/xhtml", tag
		"concat slice splice map".split(" ").forEach (name)->
			XPath.Class::[name] = do(method=XPath.Class::[name])-> ->
				result = new @constructor
				result.push.apply result, method.apply @, arguments
				result
		XPath.Utils.$L = $L
		XPath.Utils.$A = $A
		XPath.Utils.$ID = $ID
		XPath.Utils.$C = $C
		XPath.Utils.$N = $N
		XPath.Utils.$R = $R
		XPath.Utils.$svg = $svg
		XPath.Utils.$html = $html

		window.$L = $L###!SCRIPT###
		window.$A = $A###!SCRIPT###
		window.$ID = $ID###!SCRIPT###
		window.$C = $C###!SCRIPT###
		window.$N = $N###!SCRIPT###
		window.$R = $R###!SCRIPT###
		window.$svg = $svg###!SCRIPT###
		window.$html = $html###!SCRIPT###
