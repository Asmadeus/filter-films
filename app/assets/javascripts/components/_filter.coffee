class @Filter
  constructor: (options) ->
    obj = @
    @elem = options.elem
    @filterCategories = @elem.find(".filter-item")
    @clearFilterBtn = @elem.find(".clear-all-filter")

    @gridData = options.gridData

    @filterCategories.each ->
      filter = $(@)
      filterSearch(filter)
      filterAction(filter, obj)

    @clearFilterBtn.click ->
      obj.gridData.currentQuery = obj.gridData.apiUrl
      obj.gridData.getFilms(obj.gridData.currentQuery)
      clearFilter(obj.elem)

    @elem.click (e) ->
      if !$(e.target).closest(obj.clearFilterBtn).length
        $("header").removeClass("close-filter") if $("header").hasClass("close-filter")

  filterAction = (filter, obj) ->
    category = filter.data("category")
    filterTitleElem = filter.find(".filter-title")
    filter.find(".filter-item-value").click ->
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

  filterSearch = (filter) ->
    filter.find(".search-filter input").on("input", ->
      value = $(@).val().toLowerCase()
      items = filter.find(".filter-item-value")
      if value.replace(/\s/g, "").length
        count = 0
        items.each ->
          if $(@).text().toLowerCase().indexOf(value) == -1
            $(@).hide()
          else
            $(@).show()
            count++
        menu = filter.find(".filter-item-menu")
        if !count
          if !$(menu).find(".no-result").length
            $(menu).append("<span class='no-result'>No matches found</span>")
        else
          $(menu).find(".no-result").remove()
      else if !value.length
        items.each ->
          $(@).show()
    )

  clearFilter = (elem) ->
    $("header").addClass("close-filter")
    elem.find(".filter-item").each ->
      $(@).find(".filter-title").text("")
      $(@).find(".filter-item-value").removeClass("select")
      $(@).removeClass("select")
      $(@).find(".search-filter input").val("")
      $(@).find(".filter-item-menu .filter-item-value").show()

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
