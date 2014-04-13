window.app.factory 'instance', ['$http', '$q', ($http, $q) ->
	(url) ->
		$http
			method: 'GET'
			url: '/proxy' + url
			cache: true
			transformResponse: (data, headersGetter) ->
				console.log(data, headersGetter)
]
