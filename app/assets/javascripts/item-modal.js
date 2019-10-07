$(function(){
  $('.items-status__delete-btn').on('click',function(){
    $('.modal').fadeIn();
    $('body').css("overflow", "hidden");
    return false;
  });
  $('.cancel-btn').on('click',function(){
    $('.modal').fadeOut();
    $('body').css("overflow", "scroll");
  });
  $('.delete-btn').on('click', function(){
    $('.modal').fadeOut();
  });
});