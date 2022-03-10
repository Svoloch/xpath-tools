export default do->###!IMPORT###
do do(XPath = window.$X)->###!SCRIPT###
	events = """
click dblclick mousedown mouseup mouseover mousemove mouseout dragstart drag dragenter
dragleave dragover drop dragend keydown keypress keyup load unload abort
error resize scroll select change submit reset focus blur focusin
focusout DOMActivate DOMSubtreeModified DOMNodeInserted DOMNodeRemoved
DOMNodeRemovedFromDocument DOMNodeInsertedIntoDocument DOMAttrModified DOMCharacterDataModified
touchstart touchend touchmove touchenter touchleave
touchcancel pointerdown pointerup pointercancel pointermove
pointerover pointerout pointerenter pointerleave gotpointercapture
lostpointercapture cut copy paste beforecut
beforecopy beforepaste afterupdate beforeupdate cellchange
dataavailable datasetchanged datasetcomplete errorupdate rowenter
rowexit rowsdelete rowinserted contextmenu
selectstart help beforeunload stop beforeeditfocus
start finish bounce beforeprint afterprint
propertychange filterchange readystatechange losecapture DOMMouseScroll
dragdrop dragexit draggesture CheckboxStateChange RadioStateChange close command input
DOMMenuItemActive DOMMenuItemInactive overflow overflowchanged
underflow popuphidden popuphiding popupshowing popupshown broadcast commandupdate
""".split /\s/
	(XPath)->
		XPath.events = events
		events.forEach (event)->
			XPath.Class::[event] = (callback)->@on event, callback
