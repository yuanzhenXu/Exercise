$ ->
  $('.admin-order-form').submit ->
    $state = $('#order_state')

    if $state .val() == 'returned' && $state.data('show-refund-tip') == 'on'
      return confirm('此项操作将会把订单费用退回给购买者，是否继续操作？')

    return true;

  $('.order-sync-btn').click (e) ->
    e.preventDefault()
    $btn = $(this)
    url = $btn.attr('href')
    $.ajax(
      url: $btn.attr('href')
      method: 'post'
    ).done (data)->
      $btn.siblings(".sync-text").html(data.msg)
      