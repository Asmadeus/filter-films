class @Sort
  constructor: (options) ->
    obj = @
    @elem = options.elem
    @gridData = options.gridData
    @sortCategories = @elem.find(".select-order-value")

    @sortCategories.click ->
      category = $(@).data("order-category")
      if !$(@).hasClass("select")
        obj.gridData.sortKey = category
        url = "#{obj.gridData.currentQuery}&order=#{category}&"
        obj.gridData.currentQuery = url
        obj.gridData.getFilms(url, true)
        obj.sortCategories.removeClass("select")
        $(@).addClass("select")

        obj.elem.find(".order-title").text("Order #{$(@).text()}")
