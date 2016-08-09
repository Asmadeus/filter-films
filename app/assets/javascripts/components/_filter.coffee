class @Filter
  constructor: (options) ->
    obj = @
    @elem = options.elem
    @filterCategories = @elem.find(".filter-item")
    @clearFilterBtn = @elem.find(".clear-all-filter")
    @gridData = options.gridData

    @filterCategories.each ->
      filter = $(@)
      category = $(@).data("category")
      filterTitleElem = $(@).find(".filter-title")
      $(@).find(".filter-item-value").click ->
        unit = $(@).data("category-value")
        if $(@).hasClass("select")
          obj.gridData.currentQuery = obj.gridData.currentQuery.replace("#{category}[]=#{unit}&","")
          removeFilterTitle(filterTitleElem, $(@).text())
        else
          obj.gridData.currentQuery += "#{category}[]=#{unit}&"
          addFilterTitle(filterTitleElem, $(@).text())

        $(@).toggleClass("select")
        obj.gridData.getFilms(obj.gridData.currentQuery)

        if filter.find(".filter-item-value.select").length
          filter.addClass("select")
        else
          filter.removeClass("select")

    @clearFilterBtn.click ->
      obj.gridData.currentQuery = obj.gridData.apiUrl
      obj.gridData.getFilms(obj.gridData.currentQuery)
      clearFilter(obj.filterCategories)

    @filterCategories.click ->
      if $(@).hasClass("open")
        $(@).find(".filter-item").hide()
        $(@).find(".empty-filter-item").hide()
        $(@).find(".search-filter").show()


  clearFilter = (elem) ->
    elem.each ->
      $(@).find(".filter-title").text("")
      $(@).find(".filter-item-value").removeClass("select")
      $(@).removeClass("select")

  # Удаление названия фильтра при отключении
  # filterTitleElem - элемент в котором меняется названия фильтров
  # itemTitle - название фильтра, которое нужно удалить
  removeFilterTitle = (filterTitleElem, itemTitle) ->
    textTitle = filterTitleElem.text()
    if filterTitleElem.text().indexOf(itemTitle) == 0
      if itemTitle == filterTitleElem.text()
        textTitle = textTitle.replace("#{itemTitle}","")
      else
        textTitle = textTitle.replace("#{itemTitle}, ","")
    else
      textTitle = filterTitleElem.text().replace(", #{itemTitle}","")
    filterTitleElem.text(textTitle)

  # Добавление названия фильтра при включении
  # filterTitleElem - элемент в котором меняется названия фильтров
  # itemTitle - название фильтра, которое нужно добавить
  addFilterTitle = (filterTitleElem, itemTitle) ->
    textTitle = filterTitleElem.text()
    if !textTitle.length
      textTitle = itemTitle
    else
      textTitle += ", #{itemTitle}"
    filterTitleElem.text(textTitle)
