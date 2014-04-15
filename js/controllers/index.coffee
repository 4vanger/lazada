window.app.controller 'IndexCtrl', ['$scope', 'instanceModel', ($scope, instanceModel) ->
	$scope.instances = []
	$scope.errors = []
	$scope.show = 'all' # show all fields by default
	$scope.fields = {}
	# store flags if field has same values or different to not recalculate every time
	$scope.fieldSame = {}
	$scope.addInstances = ->
		return if $scope.addInstancesForm.$invalid
		if $scope.addInstanceUrl1 == $scope.addInstanceUrl2
			$scope.errors.push 'This products are the same.'
			return

		$scope.addInstance $scope.addInstanceUrl1
		$scope.addInstance $scope.addInstanceUrl2
		$scope.hideInitialForm = true

	$scope.addInstance = (url) ->
		if (true for instance in $scope.instances when instance.url == url).length > 0
			$scope.errors.push 'This phone is added to comparison already.'
			return

		instanceData = url: url
		$scope.instances.push instanceData
		instanceModel(url).then(
			# success
			(data) ->
				angular.extend instanceData, data
				calculateFields()
			# error
			(msg) -> $scope.errors.push msg
		)

	calculateFields = ->
		# instances has changed - update indexes
		$scope.fields = {}
		for instance, index in $scope.instances
			for field, value of instance.fields
				unless $scope.fields[field]
					# add record for new field
					$scope.fields[field] = new Array($scope.instances.length)
				$scope.fields[field][index] = value
		# calculate which rows consist of same values
		for field, values of $scope.fields
			$scope.fieldSame[field] = true
			val = values[0]
			for value in values
				if value != val
					$scope.fieldSame[field] = false
					break
	# when collection updates - recalculate fields
	$scope.$watch 'instances.length', calculateFields()

	$scope.removeError = (index) -> $scope.errors.splice(index, 1)

	$scope.removeInstance = (instanceObj) ->
		if confirm('Are you sure you want to remove ' + instanceObj.title + ' from comparison?')
			$scope.instances = (instance for instance in $scope.instances when instance != instanceObj)
			calculateFields()
#	$scope.addInstance('http://www.lazada.vn/apple-iphone-5c-retina-4-8mp-32gb-vang-106908.html')
#	$scope.addInstance('http://www.lazada.vn/apple-iphone-5c-retina-4-8mp-16gb-trang-106901.html')
#	$scope.addInstance('http://www.lazada.vn/apple-iphone-5s-retina-4-8mp-16gb-gold-107692.html')
#	$scope.addInstance('http://www.lazada.vn/zenus-iphone-5cretrozdiary-bao-da-dien-thoai-hong-94480.html')
]
