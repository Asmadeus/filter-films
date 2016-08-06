$(document).ready ->

  menus = []
  $(".c-dropdown").each ->
    menu = new DropdownMenu(elem: $(this))
    menus.push(menu)

  gridData = new GridData()

  mainSearch = new Search(
    elem: $("header .search")
    gridData: gridData
  )

  filter = new Filter({
    elem: $("header .filters")
    gridData: gridData
  })

  sort = new Sort({
    elem: $(".select-order")
    gridData: gridData
  })
