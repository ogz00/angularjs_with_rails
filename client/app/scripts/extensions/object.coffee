Object.traverseKeysRecursive = (data, func) ->
  newData = undefined
  if data instanceof Array
    newData = []
    i = 0
    while i < data.length
      newData[i] = Object.traverseKeysRecursive(data[i], func)
      i++
  else if data instanceof Object
    #    console.log("object",data);
    newData = {}
    for k of data
      if data.hasOwnProperty(k)
        newKey = func(k)
        newData[newKey] = Object.traverseKeysRecursive(data[k], func)
  else
    newData = data
  newData

Object.toUnderscoreKeys = (data) ->
  Object.traverseKeysRecursive data, (k) ->
    k.toUnderscore()

Object.toCamelKeys = (data) ->
  Object.traverseKeysRecursive data, (k) ->
    k.toCamel()

Object.merge = (firstObject, otherObject, keys) ->
  `var k`
  if !keys
    keys = []
    for k of otherObject
      if otherObject.hasOwnProperty(k)
        keys.push k
  i = 0
  while i < keys.length
    k = keys[i]
    firstObject[k] = otherObject[k]
    i++
  return

Object.removeNullsAndEmpties = (object, keys) ->
  i = 0
  while i < keys.length
    k = keys[i]
    if object[k] == null or object[k] == ''
      delete object[k]
    i++
  return

Object.removeTextNulls = (object, keys) ->
  i = 0
  while i < keys.length
    k = keys[i]
    if object[k] == 'null'
      delete object[k]
    i++
  return
