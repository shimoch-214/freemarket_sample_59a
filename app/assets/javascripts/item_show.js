$(function() {
  var parent_photo = $('.show-items__photo-size-parent--list')
  var child_photo = $('.show-items__photo-size-child--list')
  var photo_size = parent_photo.children().length
  parent_photo.css({width: `${photo_size * 300 - 300}`});
  $('.show-items__photo--child :first-child').css({opacity: .9});

  child_photo.on('mouseenter', function(){
    child_photo.css({opacity: .3});
    $(this).css({opacity: .9});
    var index_chilled = child_photo.index(this);
    parent_photo.stop();
    parent_photo.animate({left:`${index_chilled * -300}px`}, { duration: 'slow'});
  })
})