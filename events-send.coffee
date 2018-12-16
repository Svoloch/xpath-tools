
$X.Class.dispatch = do->
	events =
		click: MouseEvent
		dblclick: MouseEvent
		mouseup: MouseEvent
		mousedown: MouseEvent

		wheel: WheelEvent

		drag: DragEvent
		dragend: DragEvent
		dragenter: DragEvent
		dragexit: DragEvent
		dragleave: DragEvent
		dragover: DragEvent
		dragstart: DragEvent
		drop: DragEvent

		focus: FocusEvent
		blur: FocusEvent
		focusin: FocusEvent
		focusout: FocusEvent
		
		keydown: KeyboardEvent
		keypress: KeyboardEvent
		keyup: KeyboardEvent

		input: InputEvent

		compositionstart: CompositionEvent
		compositionend: CompositionEvent
		compositionupdate: CompositionEvent

		pointerover: PointerEvent
		pointerenter: PointerEvent
		pointerdown: PointerEvent
		pointermove: PointerEvent
		pointerup: PointerEvent
		pointercancel: PointerEvent
		pointerout: PointerEvent
		pointerleave: PointerEvent
		gotpointercapture: PointerEvent
		lostpointercapture: PointerEvent

	dispatch = (name, params={})->
		E = dispatch.events[name] ? if params.detail == null
			Event
		else CustomEvent
		for element in @ when typeof element.dispatchEvent == 'function'
			event = new E name, params
			element.dispatchEvent event
	dispatch.events = events
	dispatch
