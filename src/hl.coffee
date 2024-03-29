`import extraUtils from "./extra-utils.js"`###!IMPORT###
export default do->(XPath)->###!IMPORT###
do(XPath = window.$X)->###!SCRIPT###
		XPath.use extraUtils###!IMPORT###
		$A = XPath.Utils.$A
		$C = XPath.Utils.$C
		$html = XPath.Utils.$html
		XPath.Class::unwrap = ->
			@forEach (node)->
				if parent = node.parentNode
					while child = node.firstChild
						parent.insertBefore child, node
					parent.removeChild node
		XPath.Class::normalizeText = ->
			@forEach (item)->
				if item instanceof Element
					texts = [[]]
					for node in item.childNodes
						if node instanceof Text
							texts[0].push node
						else
							if texts[0].length
								texts.unshift []
					texts.reverse().forEach (seq)->
						if seq.length>1
							text = seq.map((node)->node.nodeValue).join ''
							$A(text).insertBefore seq[0]
							seq.forEach (node)->$A(node).remove()
			@
		XPath.Class::unspan = (cls)->
			spans = $A(@map (n)-> $C cls , n)
				.xpathFilter "local-name()='span'"
			parents = spans.xpath("..").unique()
			spans.unwrap()
			parents.normalizeText()
			@
		XPath.Class::highlight = do->
			encode = (text)->
				text.replace /[&\<\>\'\"]/, (char)->
					"&#{char.charCodeAt(0)};"
			(cls, text)->
				out = []
				if text
					@
						.xpath ".//text()"
						.xpathFilter "contains(.,'#{encode text}')"
						.forEach (textNode)=>
							splitted = textNode.nodeValue.split text
							nodes = $A splitted.shift()
							while splitted.length
								span = $html.span(cls).append(text)[0]
								nodes.push span, splitted.shift()
								out.push span
							nodes.insertBefore textNode
							$A(textNode).remove()
				$A out
