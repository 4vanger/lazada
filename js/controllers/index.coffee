window.app.controller 'IndexCtrl', ['$scope', 'instance', ($scope, instance) ->
	$scope.instances = []
	$scope.errors = []
	$scope.addInstanceUrl = 'http://www.lazada.vn/apple-iphone-5c-retina-4-8mp-32gb-vang-106908.html'
	$scope.addNewInstance = ->
		return if $scope.addInstanceForm.$invalid
		addInstance($scope.addInstanceUrl.replace(/https?:\/\/(www\.)?lazada.vn\//, ''))
		$scope.addInstanceUrl = ''
	addInstance = (url) ->
		instance(url).then(
			# success
			(data) -> $scope.instances.push data
			# error
			(msg) -> $scope.errors.push msg
		)
	# DEBUG
	addInstance 'nokia-105-man-hinh-mau-14-xanh-76651.html'
]
