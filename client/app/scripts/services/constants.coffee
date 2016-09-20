'use strict'

###*
 # @ngdoc service
 # @name puzzles.actionStates
 # @description
 # # actionStates
 # Constant in the puzzles.
###
angular.module 'puzzles'
  .constant 'constants',
  formValidations:
    toShort: 'çok kısa.'
    required: 'information is required; Please fill in.'
    incompatibleWithPattern: 'You have entered the incorrect format.'
    incompatibleWithOther: 'information incompatible with each other.'
  actionStates:
    onIdle:0
    onAction:1
  errorCodes:
    2001: 'Puzzle Stats Not Found"'
    2002: "Puzzle hasn't Answered Yet"

