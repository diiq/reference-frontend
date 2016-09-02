import angular from 'angular';
import ReferenceThumbnail from './referenceThumbnail/referenceThumbnail';

let referencesModule = angular.module('references', [
  ReferenceThumbnail
]).name;

export default referencesModule;
