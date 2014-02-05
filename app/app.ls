CryptoJS = require 'crypto-js'

update-action = (scope, name, value) ->
  s = scope.$parent
  while s isnt void
    if s.hasOwnProperty \actions
      console.log \updating, name, value
      s.actions[name] = value
      break
    else
      s = s.$parent

app = angular.module \moltenpad, [\angularLocalStorage]
app.directive \textInput ->
  restrict: \E
  scope:
    v: \=for
    placeholder: \@
    actionItemId: \@for
  templateUrl: 'partials/checkbox.html'
  controller: ($scope, $rootScope) ->
    $rootScope.registerAction $scope.actionItemId

app.directive \checkbox ->
  restrict: \E
  scope:
    label: \@
  templateUrl: 'partials/checkbox.html'
  controller: ($scope) ->
    $scope.actionId = CryptoJS.MD5($scope.label).toString(CryptoJS.enc.Hex)
    console.log \labe, $scope.label
    update-action $scope.actionId, void
    $scope.$watch \v ->
      console.log \value, it
      console.log \scope, $scope
      update-action $scope, $scope.actionId, it

app.directive \progressBar ->
  restrict: \E
  templateUrl: 'partials/progress_bar.html'

app.controller \moltenCtrl, ($scope, storage) !->
  storage.bind $scope, 'actions'
  $scope.actions ||= {}

  $scope.registerAction = (id) ->
    varName = id.replace "actions.", ""
    $scope.actions <<< { "#{varName}": void } unless $scope.actions[varName]

  <- $scope.$watch \actions _, true
  completed = [k for k, v of $scope.actions when v and v != ""].length
  $scope.percentage = completed / Object.keys($scope.actions).length * 100