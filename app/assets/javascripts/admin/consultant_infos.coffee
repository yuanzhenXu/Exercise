$ ->
  if $('form.consultant_info').length
    $('#consultant_info_user_id').select2
      width: '100%'
      # allowClear: true  
      ajax:
        url: '/admin/consultant_infos/users'
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
