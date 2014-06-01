CryptoJS = require 'crypto-js'

app = angular.module \app, <[angularLocalStorage]>
.config ($locationProvider) ->
  $locationProvider.html5Mode yes

.controller \appCtrl, ($scope, storage, $location, $http, $anchorScroll) !->
  do
    id = $location.path!substr 1
    csv <~ $http.get "https://www.ethercalc.org/_/#id/csv" .success _
    #csv <- $http.get "/#id.csv" .success _
    $scope.csv = CSV.parse csv

  storage.bind $scope, 'progress', defaultValue: {}
  $scope.contents = []
  $scope.headers = []

  $scope.register = (id, default-value) ->
    $scope.progress[id] = default-value if $scope.progress[id] == void

  $scope.reset = ->
    for k, v of $scope.progress
      $scope.progress[k] = void

  do
    <- $scope.$watch \progress, _, true
    completed = [k for k, v of $scope.progress when v and v != ""].length
    $scope.percentage = completed / Object.keys($scope.progress).length * 100

  $scope.gotoHash = ->
    $anchorScroll!

  $scope.parse = (parsed) ->
    return unless parsed

    parse =
      h: (row) ->
        lvl = row.0.match /^(#+)/ .0.length
        h = row.0.replace /^(#+)/, ''
        h-id = h.replace /[\s\.\[\]\/#$]/g, \-
        o = h: h, lvl: lvl, hId: h-id
        $scope.contents.push o
        $scope.headers.push(o <<< href: "\##{h-id}")
      p: (row) ->
        $scope.contents.push p: row.0
      a: (row) ->
        var url
        url = row.1 if row.1
        attrs = JSON.parse row.2 if row.2
        a = row.0.replace /^\-/, ''
        a-id = CryptoJS.MD5(a).toString(CryptoJS.enc.Hex)
        $scope.contents.push a: a, actionId: a-id, link: url, attrs: attrs
        $scope.register a-id, false

    parsed.shift! # remove header
    for x, i in parsed
      switch
      | x[0][0] == "#" => parse.h x
      | x[0][0] == "-" => parse.a x
      | otherwise      => parse.p x

  $scope.$watch \csv, $scope.parse
