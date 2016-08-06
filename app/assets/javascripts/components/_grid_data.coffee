class @GridData
  constructor: (options) ->
    obj = @
    @itemTemplate = Handlebars.compile($('#grid-item-template').html())
    @currentData = []
    @apiUrl = "https://ororo.tv/api/v2/shows?"
    @currentQuery = @apiUrl
    @sortKey = ""

    @getFilms = (url, searchText) ->
      $.ajax
        url: url
        beforeSend: (xhr) ->
          xhr.setRequestHeader("Authorization", "Basic " + btoa('test@example.com:password'))
        success: (result) ->
          obj.currentData = result.shows
          console.log obj.currentQuery
          # if !!obj.sortKey
          #   console.log 1
          obj.renderData()
          if !!searchText
            obj.hideItemGrid(searchText)

    @renderData = () ->
      $(".content .grid-content").html(obj.itemTemplate(obj.currentData))

    @hideItemGrid = (value) ->
      value = value.toLowerCase()
      $(".grid-item").each ->
        if $(@).find(".title").text().toLowerCase().indexOf(value) == -1
          $(@).hide()
        else
          $(@).show()

    @getFilms(@currentQuery, "")
