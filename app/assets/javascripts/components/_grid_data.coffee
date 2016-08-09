class @GridData
  constructor: (options) ->
    obj = @
    @currentData = []
    @apiUrl = "https://ororo.tv/api/v2/shows?"
    @currentQuery = @apiUrl

    itemTemplate = Handlebars.compile($('#grid-item-template').html())
    resultData = []

    @getFilms = (url, showImmediately = false) ->
      $.ajax
        url: url
        beforeSend: (xhr) ->
          xhr.setRequestHeader("Authorization", "Basic " + btoa('test@example.com:password'))
        success: (result) ->
          obj.currentData = result.shows
          textSearch = $(".search-field").val().toLowerCase()
          resultData = obj.currentData
          resultChange = false
          if textSearch.length and textSearch.replace(/\s/g, "").length
            resultChange = true
            resultData = resultData.filter( (item) ->
              return item.name.toLowerCase().indexOf(textSearch) != -1
            )

          if detectMobileDevice()
            count = if resultChange then resultData.length else obj.currentData.length
            $(".show-result-mobile").text("Show results: #{count}")
            if showImmediately
              obj.renderData()
          else
            obj.renderData()

    @renderData = () ->
      $(".content").show()
      $(".content .grid-content").html(itemTemplate(resultData))
      $(".line-block .title").text("#{resultData.length} shows found")


    $(".show-result-mobile").click ->
      obj.renderData()

    @getFilms(@currentQuery)
