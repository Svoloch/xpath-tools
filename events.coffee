
"""
click dblclick mousedown mouseup mouseover
mousemove mouseout dragstart drag dragenter
dragleave dragover drop dragend keydown
keypress keyup load unload abort
error resize scroll select change
submit reset focus blur focusin
focusout DOMActivate DOMSubtreeModified DOMNodeInserted DOMNodeRemoved
DOMNodeRemovedFromDocument DOMNodeInsertedIntoDocument DOMAttrModified DOMCharacterDataModified
touchstart touchend touchmove touchenter touchleave
touchcancel pointerdown pointerup pointercancel pointermove
pointerover pointerout pointerenter pointerleave gotpointercapture
lostpointercapture cut copy paste beforecut
beforecopy beforepaste afterupdate beforeupdate cellchange
dataavailable datasetchanged datasetcomplete errorupdate rowenter
rowexit rowsdelete rowinserted contextmenu drag
dragstart dragenter dragover dragleave dragend
drop selectstart help beforeunload stop beforeeditfocus
start finish bounce beforeprint afterprint
propertychange filterchange readystatechange losecapture DOMMouseScroll
dragdrop dragenter dragexit draggesture dragover
CheckboxStateChange RadioStateChange close command input
DOMMenuItemActive DOMMenuItemInactive contextmenu overflow overflowchanged
underflow popuphidden popuphiding popupshowing popupshown
broadcast commandupdate
""".split(/\s/).forEach (event)->
	$X.Class::[event] = (callback)->@on event, callback
