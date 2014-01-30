// Generated by LiveScript 1.2.0
(function(){
  var app;
  app = angular.module('moltenpad', ['angularLocalStorage']);
  app.directive('textInput', function(){
    return {
      restrict: 'E',
      scope: {
        v: '=for',
        placeholder: '@',
        actionItemId: '@for'
      },
      template: '<div class="ui large input"><input type="text" ng-model="v" placeholder="{{placeholder}}"/></input>',
      controller: function($scope, $rootScope){
        return $rootScope.registerAction($scope.actionItemId);
      }
    };
  });
  app.directive('checkbox', function(){
    return {
      restrict: 'E',
      scope: {
        v: '=for',
        label: '@',
        actionItemId: '@for'
      },
      template: '<div class="ui large checkbox"><input id="{{actionItemId}}" type="checkbox" ng-model="v" /><label for="{{actionItemId}}">{{label}}</label></div>',
      controller: function($scope, $rootScope){
        return $rootScope.registerAction($scope.actionItemId);
      }
    };
  });
  app.directive('progressBar', function(){
    return {
      restrict: 'E',
      template: "<div class=\"ui successful progress\">\n  <div class=\"bar\" style=\"width:{{percentage}}%\"></div>\n</div>"
    };
  });
  app.controller('moltenCtrl', function($rootScope, storage){
    storage.bind($rootScope, 'actions');
    $rootScope.actions || ($rootScope.actions = {});
    $rootScope.registerAction = function(id){
      var varName, ref$;
      varName = id.replace("actions.", "");
      if (!$rootScope.actions[varName]) {
        return ref$ = $rootScope.actions, ref$[varName + ""] = void 8, ref$;
      }
    };
    $rootScope.$watch('actions', function(){
      var max, completed, k, ref$, v;
      max = 0;
      completed = 0;
      for (k in ref$ = $rootScope.actions) {
        v = ref$[k];
        max += 1;
        if (v && v !== "" && v !== false) {
          completed += 1;
        }
      }
      return $rootScope.percentage = completed / max * 100;
    }, true);
  });
}).call(this);
