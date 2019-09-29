$(function() {
  $('#category-parent').on('change', function(){
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
})