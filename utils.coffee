
$A = (arrs...)->
	result = new $X.Class
	for arr in arrs
		result.push.apply result, arr
	result
$svg = (tag)-> $A [document.createElementNS "http://www.w3.org/2000/svg", tag]
$html = (tag)-> $A [document.createElementNS "http://www.w3.org/1999/xhtml", tag]
$ID = (ids...)-> $A (for id in ids then document.getElementById id)
$C = (cls)-> $A document.getElementsByClassName cls
$N = (name, root)-> $X "//*[@name=#{JSON.stringify name}]", root
$L = console.log.bind console

$R = do->
	list = []
	(callback)->
		unless document.readyState == "complete"
			($A [document]).on 'DOMContentLoaded', -> do callback
		else
			if list.length
				list.push callback
			else
				list.push callback
				while list.length
					try
						do list[0]
					catch e
						setTimeout (->throw e), 10
					finally
						list.shift()
