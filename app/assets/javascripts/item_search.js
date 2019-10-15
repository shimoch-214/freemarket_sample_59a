$(function() {
  $('.js_category_none').hide()
  $('.js_sizing_none').hide()
  var sizing_checked_length = ""
  var select_sizing = ""

  // category_selectboxで選択した値をchild_category_selectboxに反映させる
  $('.js_category_form').change(function() {
    var val = $('.js_category_form').val()
    $(this).parent().find('.js_category_child_form').val("")
    $(this).parent().find('input[type="checkbox"]').prop('checked', false)
    $('.js_category_none').hide()
    $('#category_child_'+val).show()
    
    // $('.js_none').hide()
    // $(this).parent().find('input[type="checkbox"]').prop('checked', false)
    // $('#category_'+val).show()
  });
  $('.js_category_child_form').change(function() {
    console.log('ok')
    var val = $('.js_category_child_form').val()
    select_sizing = $('#category_grandchild_'+val)
    $(this).parent().find('input[type="checkbox"]').prop('checked', false)
    $('.js_category_grandchild_none').hide()
    $('#category_grandchild_'+val).show()
  });

  // size_selectboxで選択した値をcheckboxに反映させる
  $('.js_sizing_form').change(function() {
    var val = $('.js_sizing_form').val()
    select_sizing = $('#sizing_'+val)
    $(this).parent().find('input[type="checkbox"]').prop('checked', false)
    $('.js_sizing_none').hide()
    $('#sizing_'+val).show()

    // // checkboxの数
    // var input_length = select_sizing.children().children('input').length
    // console.log(input_length)
    // // checkされた数
    // sizing_checked_length = $(`#sizing_${val} :checked`).length
    // console.log(sizing_checked_length)
  });


  // checkboxをall選択・解除
  $(".js_all_check").on('click',function(){
    $(this).parent().parent().find('input[type="checkbox"]').prop('checked', this.checked);
  })

  // price_selectboxで選択した値をtextboxに反映させる 
  $('[name=price_select]').change(function() {
    var price = $('[name=price_select] option:selected').text();
    var price_min_max = price.split(' ~ ')
    price_min = parseInt(price_min_max[0])
    if (Number.isNaN(price_min)){
      price_min = ""
    }
    price_max = parseInt(price_min_max[1])
    if (Number.isNaN(price_max)){
      price_max = ""
    }
    $('#q_price_gteq').val(price_min)
    $('#q_price_lteq').val(price_max)
  });

  // 完了ボタンを押されたら実行
  $('#detail-search').on('submit', function(e){
    // category


    // sizing
    var val = $('.js_sizing_form').val()
    var sizing_check = $(`#sizing_${val} :checked`).length
    if (sizing_check == 0 ){
      $(`#sizing_${val}`).find('input[type="checkbox"]').prop('checked', true);
    }

    // (仮)送信停止
    return true
  })
});