$(function() {
  console.log('ok')
  $('.show-items__photo-size-child--list').on('mouseenter', function(){
    console.log(this)
    $('.show-items__photo-size-child--list').css('opacity', '.3');
    $(this).css('opacity', '.9');
  })
})