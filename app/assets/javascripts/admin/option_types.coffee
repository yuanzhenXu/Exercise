$ ->
  $('.add-option-value').click (e) ->
    $temp = $('.option-value-temp')
    _old = parseInt($temp.attr('data-index'))
    _new = _old + 1
    $el = $('.option-value-temp').clone().removeClass('option-value-temp hidden')
    $el.appendTo($('.option-values-wrapper'))

    $temp.find('input').each ->
      _name = $(this).attr('name')
      if _name && _name.length
        $(this).attr('name', _name.replace(_old, _new))

      _id = $(this).attr('id')
      if _id && _id.length
        $(this).attr('id', _id.replace(_old, _new))

    $temp.attr('data-index', _new)

  $('.option-values-wrapper').on 'click', '.remove-option-value', (e) ->
    $(this).siblings('input[type=checkbox]').prop('checked', true)
    $(this).closest('.option-value-item').addClass('hidden')
    