###*
# vAccordion - AngularJS multi-level accordion component
# @version v1.2.7
# @link http://lukaszwatroba.github.io/v-accordion
# @author Łukasz Wątroba <l@lukaszwatroba.com>
# @license MIT License, http://www.opensource.org/licenses/MIT
###

do (angular) ->

  vAccordionDirective = ->
    {
    restrict: 'E'
    transclude: true
    controller: AccordionDirectiveController
    scope:
      control: '=?'
      allowMultiple: '=?multiple'
      expandCb: '&?onexpand'
      collapseCb: '&?oncollapse'
    link: (scope, iElement, iAttrs, ctrl, transclude) ->

      checkCustomControlAPIMethods = ->
        angular.forEach protectedApiMethods, (iteratedMethodName) ->
          if scope.control[iteratedMethodName]
            throw new Error('The `' + iteratedMethodName + '` method can not be overwritten')
          return
        return

      transclude scope.$parent, (clone) ->
        iElement.append clone
        return
      protectedApiMethods = [
        'toggle'
        'expand'
        'collapse'
        'expandAll'
        'collapseAll'
      ]
      if !angular.isDefined(scope.allowMultiple)
        scope.allowMultiple = angular.isDefined(iAttrs.multiple)
      iAttrs.$set 'role', 'tablist'
      if scope.allowMultiple
        iAttrs.$set 'aria-multiselectable', 'true'
      if angular.isDefined(scope.control)
        checkCustomControlAPIMethods()
        mergedControl = angular.extend({}, scope.internalControl, scope.control)
        scope.control = scope.internalControl = mergedControl
      else
        scope.control = scope.internalControl
      return

    }

  # vAccordion directive controller

  AccordionDirectiveController = ($scope) ->
    ctrl = this
    isDisabled = false
    $scope.panes = []
    $scope.expandCb = if angular.isFunction($scope.expandCb) then $scope.expandCb else angular.noop
    $scope.collapseCb = if angular.isFunction($scope.collapseCb) then $scope.collapseCb else angular.noop

    ctrl.hasExpandedPane = ->
      bool = false
      i = 0
      length = $scope.panes.length
      while i < length
        iteratedPane = $scope.panes[i]
        if iteratedPane.isExpanded
          bool = true
          break
        i++
      bool

    ctrl.getPaneByIndex = (index) ->
      $scope.panes[index]

    ctrl.getPaneIndex = (pane) ->
      $scope.panes.indexOf pane

    ctrl.disable = ->
      isDisabled = true
      return

    ctrl.enable = ->
      isDisabled = false
      return

    ctrl.addPane = (paneToAdd) ->
      #console.log('pane added');
      if !$scope.allowMultiple
        if ctrl.hasExpandedPane() and paneToAdd.isExpanded
          throw new Error('The `multiple` attribute can\'t be found')
      $scope.panes.push paneToAdd
      if paneToAdd.isExpanded
        $scope.expandCb
          index: ctrl.getPaneIndex(paneToAdd)
          target: paneToAdd
      return

    ctrl.focusNext = ->
      length = $scope.panes.length
      i = 0
      while i < length
        iteratedPane = $scope.panes[i]
        if iteratedPane.isFocused
          paneToFocusIndex = i + 1
          if paneToFocusIndex > $scope.panes.length - 1
            paneToFocusIndex = 0
          paneToFocus = $scope.panes[paneToFocusIndex]
          #paneToFocus.paneElement.find('v-pane-header')[0].focus();
          break
        i++
      return

    ctrl.focusPrevious = ->
      length = $scope.panes.length
      i = 0
      while i < length
        iteratedPane = $scope.panes[i]
        if iteratedPane.isFocused
          paneToFocusIndex = i - 1
          if paneToFocusIndex < 0
            paneToFocusIndex = $scope.panes.length - 1
          paneToFocus = $scope.panes[paneToFocusIndex]
          paneToFocus.paneElement.find('v-pane-header')[0].focus()
          break
        i++
      return

    ctrl.toggle = (paneToToggle) ->
      if isDisabled or !paneToToggle
        return
      if !$scope.allowMultiple
        ctrl.collapseAll paneToToggle
      paneToToggle.isExpanded = !paneToToggle.isExpanded
      if paneToToggle.isExpanded
        $scope.expandCb index: ctrl.getPaneIndex(paneToToggle)
      else
        $scope.collapseCb index: ctrl.getPaneIndex(paneToToggle)
      return

    ctrl.expand = (paneToExpand) ->
      if isDisabled or !paneToExpand
        return
      if !$scope.allowMultiple
        ctrl.collapseAll paneToExpand
      if !paneToExpand.isExpanded
        paneToExpand.isExpanded = true
        $scope.expandCb index: ctrl.getPaneIndex(paneToExpand)
      return

    ctrl.collapse = (paneToCollapse) ->
      if isDisabled or !paneToCollapse
        return
      if paneToCollapse.isExpanded
        paneToCollapse.isExpanded = false
        $scope.collapseCb index: ctrl.getPaneIndex(paneToCollapse)
      return

    ctrl.expandAll = ->
      if isDisabled
        return
      if $scope.allowMultiple
        angular.forEach $scope.panes, (iteratedPane) ->
          ctrl.expand iteratedPane
          return
      else
        throw new Error('The `multiple` attribute can\'t be found')
      return

    ctrl.collapseAll = (exceptionalPane) ->
      if isDisabled
        return
      angular.forEach $scope.panes, (iteratedPane) ->
        if iteratedPane != exceptionalPane
          ctrl.collapse iteratedPane
        return
      return

    # API
    $scope.internalControl =
      toggle: (index) ->
        ctrl.toggle ctrl.getPaneByIndex(index)
        return
      expand: (index) ->
        ctrl.expand ctrl.getPaneByIndex(index)
        return
      collapse: (index) ->
        ctrl.collapse ctrl.getPaneByIndex(index)
        return
      expandAll: ctrl.expandAll
      collapseAll: ctrl.collapseAll
    return

  vPaneContentDirective = ->
    {
    restrict: 'E'
    require: '^vPane'
    transclude: true
    template: '<div ng-transclude></div>'
    scope: {}
    link: (scope, iElement, iAttrs) ->
      iAttrs.$set 'role', 'tabpanel'
      return

    }

  vPaneHeaderDirective = ->
    {
    restrict: 'E'
    require: [
      '^vPane'
      '^vAccordion'
    ]
    transclude: true
    template: '<div ng-transclude></div>'
    scope: {}
    link: (scope, iElement, iAttrs, ctrls) ->
      iAttrs.$set 'role', 'tab'
      paneCtrl = ctrls[0]
      accordionCtrl = ctrls[1]
      #iElement.on('click', function () {
      #  scope.$apply(function () {
      #    paneCtrl.toggle();
      #  });
      #});

      iElement[0].onfocus = ->
        paneCtrl.focusPane()
        return

      iElement[0].onblur = ->
        paneCtrl.blurPane()
        return

      #iElement.on('keydown', function (event) {
      #  if (event.keyCode === 32  || event.keyCode === 13) {
      #    scope.$apply(function () { paneCtrl.toggle(); });
      #    event.preventDefault();
      #  } else if (event.keyCode === 39) {
      #    scope.$apply(function () { accordionCtrl.focusNext(); });
      #    event.preventDefault();
      #  } else if (event.keyCode === 37) {
      #    scope.$apply(function () { accordionCtrl.focusPrevious(); });
      #    event.preventDefault();
      #  }
      #});
      return

    }

  vPaneDirective = ($timeout, $animate, accordionConfig) ->
    {
    restrict: 'E'
    require: '^vAccordion'
    transclude: true
    controller: PaneDirectiveController
    scope: isExpanded: '=?expanded'
    link: (scope, iElement, iAttrs, accordionCtrl, transclude) ->

      expand = ->
        accordionCtrl.disable()
        paneContent[0].style.maxHeight = '0px'
        paneHeader.attr
          'aria-selected': 'true'
          'tabindex': '0'
        scope.$emit 'vAccordion:onExpand'
        $timeout (->
          $animate.addClass(iElement, states.expanded).then ->
            accordionCtrl.enable()
            paneContent[0].style.maxHeight = 'none'
            scope.$emit 'vAccordion:onExpandAnimationEnd'
            return
          setTimeout (->
            paneContent[0].style.maxHeight = paneInner[0].offsetHeight + 'px'
            return
          ), 0
          return
        ), 0
        return

      collapse = ->
        accordionCtrl.disable()
        paneContent[0].style.maxHeight = paneInner[0].offsetHeight + 'px'
        paneHeader.attr
          'aria-selected': 'false'
          'tabindex': '-1'
        scope.$emit 'vAccordion:onCollapse'
        $timeout (->
          $animate.removeClass(iElement, states.expanded).then ->
            accordionCtrl.enable()
            scope.$emit 'vAccordion:onCollapseAnimationEnd'
            return
          setTimeout (->
            paneContent[0].style.maxHeight = '0px'
            return
          ), 0
          return
        ), 0
        return

      isExpanded = ->
        scope.isExpanded = angular.isDefined(iAttrs.expanded)

      transclude scope.$parent, (clone) ->
        iElement.append clone
        return
      if !angular.isDefined(scope.isExpanded)
        scope.isExpanded = angular.isDefined(iAttrs.expanded)
      states = accordionConfig.states
      paneHeader = iElement.find('v-pane-header')
      paneContent = iElement.find('v-pane-content')
      paneInner = paneContent.find('div')
      if !paneHeader[0]
        throw new Error('The `v-pane-header` directive can\'t be found')
      if !paneContent[0]
        throw new Error('The `v-pane-content` directive can\'t be found')
      accordionCtrl.addPane scope
      scope.paneElement = iElement
      scope.paneContentElement = paneContent
      scope.paneInnerElement = paneInner
      scope.accordionCtrl = accordionCtrl
      if scope.isExpanded
        iElement.addClass states.expanded
        paneContent[0].style.maxHeight = 'none'
        paneHeader.attr
          'aria-selected': 'true'
          'tabindex': '0'
      else
        paneContent[0].style.maxHeight = '0px'
        paneHeader.attr
          'aria-selected': 'false'
          'tabindex': '-1'
      scope.$watch 'isExpanded', (newValue, oldValue) ->
        if newValue == oldValue
          return true
        if newValue
          expand()
        else
          collapse()
        return
      return

    }

  # vPane directive controller

  PaneDirectiveController = ($scope) ->
    ctrl = this

    ctrl.toggle = ->
      if !$scope.isAnimating
        $scope.accordionCtrl.toggle $scope
      return

    ctrl.focusPane = ->
      $scope.isFocused = true
      return

    ctrl.blurPane = ->
      $scope.isFocused = false
      return

    return

  'use strict'
  # Config
  angular.module('vAccordion.config', []).constant 'accordionConfig', states: expanded: 'is-expanded'
  # Modules
  angular.module 'vAccordion.directives', []
  angular.module 'vAccordion', [
    'vAccordion.config'
    'vAccordion.directives'
  ]
  # vAccordion directive
  angular.module('vAccordion.directives').directive 'vAccordion', vAccordionDirective
  AccordionDirectiveController.$inject = [ '$scope' ]
  # vPaneContent directive
  angular.module('vAccordion.directives').directive 'vPaneContent', vPaneContentDirective
  # vPaneHeader directive
  angular.module('vAccordion.directives').directive 'vPaneHeader', vPaneHeaderDirective
  # vPane directive
  angular.module('vAccordion.directives').directive 'vPane', vPaneDirective
  vPaneDirective.$inject = [
    '$timeout'
    '$animate'
    'accordionConfig'
  ]
  PaneDirectiveController.$inject = [ '$scope' ]
  return

# ---
# generated by js2coffee 2.1.0
