import angular from 'angular';
import uiRouter from 'angular-ui-router';
import referenceThumbnailComponent from './referenceThumbnail.component';

let referenceThumbnailModule = angular.module('referenceThumbnail', [
  uiRouter
])

.component('referenceThumbnail', referenceThumbnailComponent)

.name;

export default referenceThumbnailModule;
