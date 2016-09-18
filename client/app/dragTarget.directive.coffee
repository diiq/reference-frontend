
angular.module('app').directive 'dragTarget', () ->
  restrict: 'A'
  scope:
    onDragOver: '&'
    onDragEnter: '&'
    onDragLeave: '&'
    onDrop: '&'
  link: (scope, $element) ->
    eventHandler = (fn) ->
      (event) ->
        event.stopPropagation()
        event.preventDefault()
        scope.$apply ->
          fn(event: event)

    element = $element[0]
    element.addEventListener 'dragover', eventHandler(scope.onDragOver), false
    element.addEventListener 'dragenter', eventHandler(scope.onDragEnter), false
    element.addEventListener 'dragleave', eventHandler(scope.onDragLeave), false
    element.addEventListener 'drop', eventHandler(scope.onDrop), false
