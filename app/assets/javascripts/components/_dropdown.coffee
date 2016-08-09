class @DropdownMenu
  constructor: (options) ->
    obj = @
    @elem = options.elem

    @elem.each ->
      $(@).click (e) ->
        e.stopPropagation()
        current = @
        if $(e.target).closest(".c-dropdown-input").length
          return
        else if $(e.target).closest(".c-dropdown-toggle").length
          obj.elem.each ->
            $(@).removeClass("open") if @ != current
          $(@).toggleClass("open")
        else if $(@).hasClass("hide-by-select") and $(e.target).closest(".c-dropdown-item").length
          $(@).removeClass("open")

    $(document).click ->
      obj.elem.removeClass("open")
