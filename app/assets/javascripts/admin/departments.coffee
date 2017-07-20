$ ->
  if $('.department-filter-form').length
    $('#level').on 'change', ->
      switch $(this).val()
        when 'first_level'
          $('.first-level-select').addClass('hidden')
          $('#first_level_id').val('-1')
          $('.second-level-select').addClass('hidden')
          $('#second_level_id').val('-1')
        when 'second_level'
          $('.first-level-select').removeClass('hidden')
          $('.second-level-select').addClass('hidden')
          $('#second_level_id').val('-1')
        else
          $('.first-level-select').removeClass('hidden')
          $('.second-level-select').removeClass('hidden')

    $('#first_level_id').on 'change', ->
      $input = $(this)
      $second_level = $('#second_level_id')
      $second_level.html '<option value="-1"></option>'
      # console.log $input.val()
      # console.log typeof($input.val())
      if $input.val() != '-1'
        $.get '/admin/departments.json', { first_level_id: $input.val() }, (data)-> 
          $.each data, (index, value) ->
            $second_level.append($('<option/>').val(value['id']).text(value['name']))
