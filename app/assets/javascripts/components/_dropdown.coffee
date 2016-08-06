class @DropdownMenu
  constructor: (options) ->
    obj = @
    @elem = options.elem

    @elem.click (e) ->
      if $(e.target).closest(".c-dropdown-toggle").length
        obj.elem.toggleClass("open")
