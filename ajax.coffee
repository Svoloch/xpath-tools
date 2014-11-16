
$XHR = do->
	class XHRClass
		constructor: (options)->
			{url, method, sync, login, password, headers, @data} = options
			@xhr = new XMLHttpRequest()
			@xhr.open method, url, !sync, login, password
			@setCallbacks options
			@setHeaders headers
		send: (txt)-> @xhr.send txt ? @data
		abort: -> do @xhr.abort
		on: (event, callback)->
			@xhr.addEventListener event, callback, false
			@
		setCallbacks: ({progress, load, abort, error})->
			@on 'progress', progress if progress?
			@on 'load', load if load?
			@on 'abort', abort if abort?
			@on 'error', error if error?
		setHeaders: (headers)->
			if headers? then for name, value in headers
				@xhr.setHeader name, value
			@
		success: (callback)->
			@on 'load', => callback @xhr.response, @
		fail: (callback)->
			@on 'error', (evt) =>
				callback evt, @
			@on 'abort', (evt) =>
				callback evt, @
		done: (callback)->
			@success (result, self)->
				callback null, result, self
			@fail (evt, self)->
				callback evt, null, self
	Class: XHRClass
	send: (method, url, txt, options={})->
		options = Object.create options
		options.method = method
		options.url = url
		options.sync = false
		request = new @Class options
		promise = new Promise (done, fail)->
			request.success done
			request.fail fail
		try #TODO move this `try` to XHRClass
			request.send txt
		catch e
			fail e
		promise
	get: (args...)->@send 'GET', args...
	put: (args...)->@send 'PUT', args...
	post: (args...)->@send 'POST', args...
	del: (args...)->@send 'DELETE', args...
	