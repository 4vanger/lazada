window.app = angular.module('lazada', ['ngRoute'])
	.config(['$routeProvider', '$httpProvider', ($routeProvider, $httpProvider) ->
		$routeProvider
			.when '/',
				controller: 'IndexCtrl'
				templateUrl: 'partials/index.html'
			.otherwise
				templateUrl: 'partials/404.html'
	])
