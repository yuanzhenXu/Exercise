fetchCategoryIds = ->
  $category_ids = $('#shelf_category_ids')
  vals = $category_ids.val()
  if vals.length
    vals.split(',')
  else
    []

$ ->
  $('#product_select').on 'click', '.item', ->
    $that = $(this)
    _id = $that.data('id').toString()
    $product_ids = $('#shelf_product_ids')
    if $product_ids.val().length
      product_ids = $product_ids.val().split(',')
    else
      product_ids = []
    
    if $that.hasClass('active')
      _index = $.inArray(_id, product_ids)
      product_ids.splice _index, 1
    else
      product_ids.push _id

    $that.toggleClass 'active'
     
    $('#shelf_product_ids').val product_ids.join(',')

    $preview = $('#edit_preview_iframe');
    $preview.attr('src', "/wechat/products/preview?ids="+product_ids.join(','))
    return

  $('.admin_shelf_form #category_ids').multiSelect
    keepOrder: true
    afterInit: (container) ->
      # that = this
      # $list = container.find('.ms-selection .ms-list')
      # category_ids = fetchCategoryIds()
      # $.each category_ids, (key, value) ->
      #   console.log that.sanitize(value);
    afterSelect: (values) -> 
      category_ids = fetchCategoryIds()
      if !category_ids.includes(values[0])
        category_ids.push(values[0])
        $('#shelf_category_ids').val category_ids.join(',')
    afterDeselect: (values) ->
      category_ids = fetchCategoryIds()
      _index = $.inArray(values[0], category_ids)
      category_ids.splice _index, 1

      $('#shelf_category_ids').val category_ids.join(',')

  # initial
  if $('#shelf_category_ids').length
    category_ids = fetchCategoryIds()
    $.each category_ids, (key, value) ->
      $('.admin_shelf_form #category_ids').multiSelect('select', value)  
