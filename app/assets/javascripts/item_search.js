$(function() {

  function priceValueCheck(price){
    price = parseInt(price)
    if (Number.isNaN(price)){
      return ""
    } else {
      return price
    }
  }
  
  function checkboxCheck(parent_box){
    // var parent_box = checkbox.parent().parent()
    var checkboxes = parent_box.find('input[type="checkbox"]')
    var checkboxes_length = checkboxes.length
    var checked_length = checkboxes.filter(":checked").length
    var all_check = parent_box.find(".js_all_check")
    var all_check_state = all_check.prop('checked')
    all_check.prop('checked', false)
    if (checked_length == checkboxes_length - 1 && all_check_state == false) {
      checkboxes.prop('checked', true);
    }
  }

  // 前回の検索が「すべて」にチェックが入っていた場合、チェック状態にする
  $('.search-detail__box').find('.js_check-box').each(function() {
    checkboxCheck($(this))
  })
  
  // ブラウザ読み込み時、保持された検索項目を表示
    // category
  var checkbox_num = $('.js_category_none').find("input[type='checkbox']:checked")
  var open_checkbox = checkbox_num.parent().parent()
  var open_child_selectbox = open_checkbox.parent()
  if (checkbox_num.length != 0) {
    var retaining_child_selectbox = open_checkbox.attr('id').replace(/[^0-9^\.]/g,"")
    var retaining_parent_selectbox = open_child_selectbox.attr('id').replace(/[^0-9^\.]/g,"")
    $('select[name="category_child"]').val(retaining_child_selectbox)
    $('select[name="category"]').val(retaining_parent_selectbox)
  }
  $('.js_category_none').not(open_checkbox).not(open_child_selectbox).hide()
    // sizing
  var sizing_checkbox_num = $('.js_sizing_none').find("input[type='checkbox']:checked")
  var open_sizing_checkbox = sizing_checkbox_num.parent().parent()
  if (sizing_checkbox_num.length != 0) {
    var retaining_child_selectbox = open_sizing_checkbox.attr('id').replace(/[^0-9^\.]/g,"")
    $('select[name="sizing"]').val(retaining_child_selectbox)
  }
  $('.js_sizing_none').not(open_sizing_checkbox).hide()

  // category_selectboxで選択した値をchild_category_selectboxに反映させる
  $('.js_category_form').change(function() {
    var val = $(this).val()
    $(this).parent().find('.js_category_child_form').val("")
    $(this).parent().find('input[type="checkbox"]').prop('checked', false)
    $('.js_category_none').hide()
    $('#category_child_'+val).show()
  });
  $('.js_category_child_form').change(function() {
    var val = $(this).val()
    select_category = $('#category_grandchild_'+val)
    $(this).parent().find('input[type="checkbox"]').prop('checked', false)
    $('.js_category_grandchild_none').hide()
    select_category.show()
  });

  // size_selectboxで選択した値をcheckboxに反映させる
  $('.js_sizing_form').change(function() {
    var val = $('.js_sizing_form').val()
    select_sizing = $('#sizing_'+val)
    $(this).parent().find('input[type="checkbox"]').prop('checked', false)
    $('.js_sizing_none').hide()
    $('#sizing_'+val).show()
  });

  // checkboxをall選択・解除
  $(".js_all_check").on('click',function(){
    $(this).parent().parent().find('input[type="checkbox"]').prop('checked', this.checked);
  })

  // checkboxが「全部」以外全て押された時、「全部」を選択する。外されたら解除する。
  $(".js_check").on('click',function(){
    var parent_box = $(this).parent().parent()
    checkboxCheck(parent_box)
  })


  // price_selectboxで選択した値をtextboxに反映させる 
  $('[name=price_select]').change(function() {
    var price = $('[name=price_select] option:selected').text();
    var price_min_max = price.split(' ~ ')
    price_min = priceValueCheck(price_min_max[0])
    price_max = priceValueCheck(price_min_max[1])
    $('#q_price_gteq').val(price_min)
    $('#q_price_lteq').val(price_max)
  });

  // reset_buttonが押されたら、category_checkboxとsizing_checkboxを非表示にする
  $(".search-detail__btn--clear").on('click',function(){
    $('.js_category_none').hide()
    $('.js_sizing_none').hide()
  })

  // 完了ボタンを押されたら実行
  $('#detail-search').on('submit', function(e){
    console.log("ok")
    // category
    var category_val = $('.js_category_form').val()
    var category_child_val = $('.js_category_child_form').val()
    var category_check = $(`#category_grandchild_${category_child_val} :checked`).length
    if (category_val.length == 0 || category_check > 0){
    } else if (category_child_val.length == 0 ){
      $(`#category_child_${category_val}`).find('input[type="checkbox"]').prop('checked', true);
    } else {
      $(`#category_grandchild_${category_child_val}`).find('input[type="checkbox"]').prop('checked', true);
    }
    // sizing
    var sizing_val = $('.js_sizing_form').val()
    var sizing_check = $(`#sizing_${sizing_val} :checked`).length
    console.log(sizing_check)
    if ( sizing_check == 0 ){
      $(`#sizing_${sizing_val}`).find('input[type="checkbox"]').prop('checked', true);
    }
  })
});