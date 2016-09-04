import angular from 'angular';
import loginComponent from './login/login.component';

let usersModule = angular.module('users', [
  'ng-token-auth'
])
.config(($stateProvider, $urlRouterProvider) => {
  "ngInject";

  $stateProvider
    .state('login', {
      url: '/login',
      component: 'login'
  });
})
.component('login', loginComponent)
.name;

export default usersModule;
