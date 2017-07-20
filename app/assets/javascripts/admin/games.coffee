$ ->
  $('.game_filterrific_date').datepicker
    todayBtn: 'linked'
    keyboardNavigation: false
    forceParse: false
    calendarWeeks: true
    autoclose: true
    dateFormat: "yy-mm-dd"
    onSelect: ->
      # console.log 'select'
      # console.log $(this).closest('form')
      $(this).closest('form').submit()

  $('.game-editable').editable
    ajaxOptions:
      type: 'put'
    success: (response, newValue) ->
      if(response.success)
        if response.total_times && $(this).data('name') == 'additional_times'
          console.log($(this)[0])
          $(this).closest('tr').find('.total-times').text(response.total_times)
      else
        return response.msg

  $('#game_chance_user_id').select2
    width: '100%'
    ajax:
      url: '/admin/users'
      dataType: 'json'
      delay: 300
      # cache: true
      minimumInputLength: 1
      data: (params) ->
        # console.log params
        name: params
      results: (data) ->
        return {
          results: $.map(data, (obj) ->
            { text: obj['name'], id: obj['id'] }
          )
        }
