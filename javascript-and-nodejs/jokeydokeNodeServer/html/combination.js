function CombinationCtrl($scope) {
    $scope.buttons = _.range(5);

    $scope.getTotalbuttons = function () {
        return $scope.buttons.length;
    };

    $scope.clearCompleted = function () {
        $scope.buttons = _.filter($scope.buttons, function(todo){
            return !todo.done;
        });
    };

    $scope.addbuttons = function () {
        $scope.buttons.push({text:$scope.formTodoText, done:false});
        $scope.formTodoText = '';
    };
}