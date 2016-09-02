import angular from 'angular';
import UsersService from './users.service';
import loginComponent from './login/login.component';

let usersModule = angular.module('users', [
])
.service('UsersService', UsersService)
.component('login', loginComponent)
.name;

export default usersModule;
