class @Search
  constructor: (options) ->
    obj = @
    @elem = options.elem
    @searchField = @elem.find(".search-field")
    @searchBtn = @elem.find(".search-btn")
    @gridData = options.gridData

    @searchField.on("input", ->
      obj.gridData.getFilms(obj.gridData.currentQuery)
    )

    @searchBtn.click ->
      obj.gridData.getFilms(obj.gridData.currentQuery, true)
