$(document).ready ->

  menus = new DropdownMenu(elem: $(".c-dropdown"))

  gridData = new GridData()

  mainSearch = new Search(
    elem: $("header .search")
    gridData: gridData
  )

  filter = new Filter({
    elem: $("header .filter-panel")
    gridData: gridData
  })

  sort = new Sort({
    elem: $(".select-order")
    gridData: gridData
  })
