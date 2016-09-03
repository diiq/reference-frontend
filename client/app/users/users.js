import angular from 'angular';
import loginComponent from './login/login.component';

let usersModule = angular.module('users', [
  'ng-token-auth'
])
.component('login', loginComponent)
.name;

export default usersModule;
