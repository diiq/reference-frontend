import angular from 'angular';
import uiRouter from 'angular-ui-router';
import Home from './home/home';
import AppComponent from './app.component';
// TODO: better bower integration pls
import '../bower_components/angular-cookie/angular-cookie';
import '../bower_components/ng-token-auth/dist/ng-token-auth';
import 'normalize.css';

angular.module('app', [
    uiRouter,
    Home,
  ])

  .config(['$locationProvider', ($locationProvider) => {
    $locationProvider.html5Mode(true).hashPrefix('!');
  }])

  .config(['$authProvider', ($authProvider) => {
    $authProvider.configure({
      apiUrl: 'http://localhost:5000/api/v1'
    });
  }])

  .component('app', AppComponent);
  
