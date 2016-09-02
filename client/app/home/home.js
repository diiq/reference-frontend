import angular from 'angular';
import uiRouter from 'angular-ui-router';
import homeComponent from './home.component';
import Users from '../users/users';

let homeModule = angular.module('home', [
  uiRouter,
  Users
])

.config(($stateProvider, $urlRouterProvider) => {
  "ngInject";

  $urlRouterProvider.otherwise('/');

  $stateProvider
    .state('home', {
      url: '/',
      component: 'home'
    });
})

.component('home', homeComponent)
  
.name;

export default homeModule;
