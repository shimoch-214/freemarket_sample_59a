$(function() {
  // functions for category selecting
  $(document).on('change', '#category-parent', function(){
    var parentId = $(this).val();
    if (parentId == '' ) {
      $('#sizing-wrapper').empty();
      $('#children-select-box').empty();
      $('#grand-children-select-box').empty();
      return;
    }
    $.ajax({
      url: '/api/categories/parent_select',
      type: 'GET',
      dataType: 'html',
      data: { parent_id: parentId }
    })
    .done(function(html) {
      $('#sizing-wrapper').empty();
      $('#children-select-box').empty();
      $('#grand-children-select-box').empty();
      $('#children-select-box').append(html);
    })
    .fail(function() {
      alert('カテゴリの取得に失敗しました。')
    })
  })
  $(document).on('change', '#category-children', function() {
    var childId = $(this).val();
    if (childId == '' ) {
      $('#sizing-wrapper').empty();
      $('#grand-children-select-box').empty();
      return;
    }
    $.ajax({
      url: '/api/categories/child_select',
      type: 'GET',
      dataType: 'html',
      data: { child_id: childId }
    })
    .done(function(html) {
      $('#sizing-wrapper').empty();
      $('#grand-children-select-box').empty();
      $('#grand-children-select-box').append(html);
    })
    .fail(function(){
      alert('カテゴリの取得に失敗しました。')
    })
  })
  $(document).on('change', '#item_category_id', function() {
    var grandChildId = $(this).val();
    if (grandChildId == '' ) {
      $('#sizing-wrapper').empty();
      return;
    }
    $.ajax({
      url: '/api/categories/grand_child_select',
      type: 'GET',
      dataType: 'html',
      data: { grand_child_id: grandChildId }
    })
    .done(function(html) {
      $('#sizing-wrapper').empty();
      $('#sizing-wrapper').append(html)
    })
    .fail(function(html) {
      alert('Internal Error')
    })
  })

  // function to confirme price
  $('#item_price').on('keyup', function() {
    var price = $(this).val();
    // console.log(isNaN(price))
    $('#commission-fee').empty();
    $('#your-profit').empty();
    if (isNaN(price) || Number(price) < 300) {
      $('#commission-fee').append('-');
      $('#your-profit').append('-');
      return
    }
    var fee = Math.floor(price*0.1)
    var profit = Math.ceil(price*0.9)
    $('#commission-fee').append(fee);
    $('#your-profit').append(profit)

  })

  // prevent submit by ENTER
  $(document).on('keydown', 'input', function(e) {
    if ((e.which && e.which === 13) || (e.keyCode && e.keyCode === 13)) {
      return false;
    } else {
      return true;
    }
  })
  $(document).on('keydown', 'select', function(e) {
    if ((e.which && e.which === 13) || (e.keyCode && e.keyCode === 13)) {
      return false;
    } else {
      return true;
    }
  })

})