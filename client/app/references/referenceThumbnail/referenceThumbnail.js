import angular from 'angular';
import referenceThumbnailComponent from './referenceThumbnail.component';

let referenceThumbnailModule = angular.module('referenceThumbnail', [
])

.component('referenceThumbnail', referenceThumbnailComponent)

.name;

export default referenceThumbnailModule;
