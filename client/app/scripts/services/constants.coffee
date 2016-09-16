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
    required: 'bilgisi gereklidir; lütfen doldurun.'
    incompatibleWithPattern: 'hatalı bir format ile girdiniz.'
    incompatibleWithOther: 'bilgileri birbiriyle uyumsuz.'
  actionStates:
    onIdle:0
    onAction:1
  errorCodes:
    2001: 'Herhangi bir ürün satın almadığınız için işlem gerçekleşmedi.'
    2002: 'Ürün daha önce satın alınmış.'
    2006: 'Herhangi bir sınav bulunamadı.'

