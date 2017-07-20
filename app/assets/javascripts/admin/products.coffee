$ ->
  $('.add-product-image').click (e) ->
    $temp = $('.product-image-temp')
    _old = parseInt($temp.attr('data-index'))
    _new = _old + 1
    $el = $('.product-image-temp').clone().removeClass('product-image-temp hidden')
    $el.appendTo($('.product-images-wrapper'))

    $temp.find('input').each ->
      _name = $(this).attr('name')
      if _name && _name.length
        $(this).attr('name', _name.replace(_old, _new))

      _id = $(this).attr('id')
      if _id && _id.length
        $(this).attr('id', _id.replace(_old, _new))

    $temp.attr('data-index', _new)

  $('.product-images-wrapper').on 'click', '.remove-product-image', (e) ->
    $(this).siblings('input[type=checkbox]').prop('checked', true)
    $(this).closest('p').addClass('hidden')

  if $('.admin-product-form').length
    $('#product_can_quick_pay').on 'change', ->
      if $(this).is( ':checked' )
        $('#product_shipping_cost').prop('disabled', false)
      else
        $('#product_shipping_cost').prop('disabled', true)
    