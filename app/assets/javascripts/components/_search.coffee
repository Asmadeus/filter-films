class @Search
  constructor: (options) ->
    obj = @
    @elem = options.elem
    @searchField = @elem.find(".search-field")
    @searchBtn = @elem.find(".search-btn")
    @gridData = options.gridData

    @searchField.on("input", ->
      value = $(@).val()
      if detectMobileDevice()
        if value.length and value.replace(/\s/g, "").length
          obj.searchBtn.addClass("active")
        else
          obj.searchBtn.removeClass("active")
      obj.gridData.getFilms(obj.gridData.currentQuery)
    )

    @searchBtn.click ->
      textSearch = obj.searchField.val().toLowerCase()
      count = obj.gridData.currentData.filter( (item) ->
        return item.name.toLowerCase().indexOf(textSearch) != -1
      ).length
      $(".show-result-mobile").text("Show results: #{count}")
