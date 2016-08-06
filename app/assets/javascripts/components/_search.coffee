class @Search
  constructor: (options) ->
    obj = @
    @elem = options.elem
    @searchField = @elem.find(".search-field")
    @gridData = options.gridData

    @searchField.on("input", ->
      value = $(@).val()
      obj.gridData.hideItemGrid(value)
    )
