class @Search
  constructor: (options) ->
    obj = @
    @elem = options.elem
    @searchField = @elem.find(".search-field")
    @searchBtn = @elem.find(".search-btn")
    @gridData = options.gridData
    timer = 0

    @searchField.on("input", ->
      value = $(@).val().toLowerCase()
      # Запрос идет по "окончанию ввода слова" - ненулевая строка, с последним символом пробела
      # или при отсутствии ввода в течение некоторого времени
      clearTimeout timer
      if !value.length
        obj.gridData.getFilms(obj.gridData.currentQuery)
      else if value.length and value.replace(/\s/g,"").length
        if value.endsWith(" ")
          obj.gridData.getFilms(obj.gridData.currentQuery)
        else
          timer = setTimeout( ->
            obj.gridData.getFilms(obj.gridData.currentQuery)
          , 1000)
    )

    @searchBtn.click ->
      obj.gridData.getFilms(obj.gridData.currentQuery, true)
