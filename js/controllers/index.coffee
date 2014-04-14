window.app.controller 'IndexCtrl', ['$scope', 'instance', ($scope, instance) ->
	$scope.instances = []
	$scope.errors = []
	$scope.addInstanceUrl = 'http://www.lazada.vn/apple-iphone-5c-retina-4-8mp-32gb-vang-106908.html'
	$scope.addInstanceUrl = 'asd'
	$scope.addNewInstance = ->
		return if $scope.addInstanceForm.$invalid
		addInstance($scope.addInstanceUrl.replace(/https?:\/\/(www\.)?lazada.vn\//, ''))
		$scope.addInstanceUrl = ''
	addInstance = (url) ->
		instanceData = {}
		$scope.instances.push instanceData
		instance(url).then(
			# success
			(data) ->
				angular.extend instanceData, data
				calculateFields()
			# error
			(msg) -> $scope.errors.push msg
		)
	$scope.fields = {}
	calculateFields = ->
		# instances has changed - update indicies
		$scope.fields = {}
		for instanceObj, index in $scope.instances
			for field, value of instanceObj.fields
				unless $scope.fields[field]
					# add record for new field
					$scope.fields[field] = new Array($scope.instances.length)
				$scope.fields[field][index] = value
	# when collection updates - recalculate fields
	$scope.$watch 'instances.length', calculateFields()
	$scope.removeError = (index) -> $scope.errors.splice(index, 1)
	# DEBUG
	addInstance 'nokia-105-man-hinh-mau-14-xanh-76651.html'
]
