window.app.factory 'instance', ['$http', '$q', ($http, $q) ->
	(url) ->
		# support older browsers
		getElementsByClassName = (el, className) ->
			if el.getElementsByClassName
				el.getElementsByClassName(className)
			else if el.querySelectorAll
				el.querySelectorAll('.' + className)
			else
				a = []
				re = new RegExp('\b' + className + '\b')
				for el in node.getElementsByTagName("*")
					a.push(els[i]) if(re.test(els[i].className))
				a
		defered = $q.defer()
		$http(
			method: 'GET'
			url: '/proxy/' + url
			cache: true
		)
		.success (data) ->
			res = id: url # use URL as an ID because it should be unique
			# use a sandbox to protect page from malicious content
			sandbox = document.createElement 'div'
			sandbox.innerHTML = data

			header = (el for el in sandbox.getElementsByTagName('h1') when el.id == 'prod_title')
			return defered.reject('Malformed page - cannot find model name') if header.length != 1
			res.title = header[0].innerHTML

			container = getElementsByClassName(sandbox, 'prd-specification')
			return defered.reject('Malformed page - cannot find specification container') if container.length != 1

			table = container[0].getElementsByTagName('table')
			return defered.reject('Malformed page - cannot find specification table') if table.length != 1

			res.fields = {}
			for row in table[0].rows
				continue if row.cells?.length != 2
				res.fields[row.cells[0].innerText] = row.cells[1].innerText
			# data extracted successfully
			defered.resolve res
		.error (error, code) -> defered.reject 'Cannot load the page: ' + code + ' ' + if error.length > 150 then error.substr(150) + '...' else error

		return defered.promise
]
