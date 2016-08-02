# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery -> 

    $('#call_list td').each (index, element) ->
      $(element).css('width', $(element).width())

    $('#call_list').sortable(
      placeholder: "ui-state-highlight"
      axis: 'y'
      items: '.pregnancy-data'
      handle: '.handle'
      cursor: 'move'
      sort: (e, ui) ->
        ui.item.addClass('active-item-shadow')
      stop: (e, ui) ->
        ui.item.removeClass('active-item-shadow')
        # highlight the row on drop to indicate an update
        ui.item.children('td').effect('highlight', {}, 500)
      update: (e, ui) ->
        item_id = ui.item[0].id
        parent = $('#'+item_id).parent()
        children = parent.children()
        order = []
        for child, value of children
          if value.id? then order.push(value.id)
        console.log(order)

        $.ajax(
          type: 'POST'
          url: '/something/reorder_pregnancies'
          dataType: 'json'
          data: { order }
        )
    )



