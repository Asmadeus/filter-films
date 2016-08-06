class @Filter
  constructor: (options) ->
    obj = @
    @elem = options.elem
    @filterCategories = @elem.find(".filter-item")
    @gridData = options.gridData

    @filterCategories.each ->
      category = $(@).data("category")
      $(@).find(".filter-item-value").click ->
        unit = $(@).data("category-value")
        if $(@).hasClass("select")
          obj.gridData.currentQuery = obj.gridData.currentQuery.replace("#{category}[]=#{unit}&","")
        else
          obj.gridData.currentQuery += "#{category}[]=#{unit}&"
        $(@).toggleClass("select")
        obj.gridData.getFilms(obj.gridData.currentQuery, $(".search-field").val())
