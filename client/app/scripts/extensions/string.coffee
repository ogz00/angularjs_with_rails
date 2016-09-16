String::toUnderscore = ->
  @replace /([A-Z])/g, ($1) ->
    '_' + $1.toLowerCase()

String::toCamel = ->
  @replace /[-_]([a-z])/g, (g) ->
    g[1].toUpperCase()
