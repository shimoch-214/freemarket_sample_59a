$(function(){
  // initialize on loading
  var count = 0;
  var image_ids = new Array
  $('#image-previews-container').children('li').each(function(i, img){
    image_ids.push($(img).attr('data-id'));
    count += 1;
  })
  $('#image_ids').val(image_ids);

  function modifyUploader(count) {
    if (count < 4){
      $(`.items-image-upload__label-has${count}`)
      .removeClass(`items-image-upload__label-has${count}`)
      .addClass(`items-image-upload__label-has${count+1}`)
    } else if (count == 4) {
      $(`.items-image-upload__label-has${count}`)
      .removeClass(`items-image-upload__label-has${count}`)
      .addClass(`items-image-upload__label-has0`)
    } else if (count > 4 && count < 9) {
      $(`.items-image-upload__label-has${count-5}`)
      .removeClass(`items-image-upload__label-has${count-5}`)
      .addClass(`items-image-upload__label-has${count-4}`)
    } else if (count == 9) {
      $(`.items-image-upload__label-has${count-5}`)
      .removeClass(`items-image-upload__label-has${count-5}`)
      .addClass(`items-image-upload__label-hasmax`)
    }
  }

  function deleteImage(count) {
    if (count < 5) {
      $(`.items-image-upload__label-has${count}`)
      .removeClass(`items-image-upload__label-has${count}`)
      .addClass(`items-image-upload__label-has${count-1}`)
    } else if (count == 5) {
      $(`.items-image-upload__label-has0`)
      .removeClass(`items-image-upload__label-has0`)
      .addClass(`items-image-upload__label-has${count-1}`)
    } else if (count > 5 && count < 10) {
      $(`.items-image-upload__label-has${count-5}`)
      .removeClass(`items-image-upload__label-has${count-5}`)
      .addClass(`items-image-upload__label-has${count-6}`)
    } else if (count == 10) {
      $(`.items-image-upload__label-hasmax`)
      .removeClass(`items-image-upload__label-hasmax`)
      .addClass(`items-image-upload__label-has${count-6}`)
    }
  }

  $('.items-image-upload__dropbox').on('drop change', `.active-input`, function(e){
    var files = e.target.files;
    if (files.length > 10) {
      alert('欲張りすぎ')
      return false;
    }
    Object.keys(files).forEach(function(key){
      var img = new FormData();
      img.append('name', files[key]);
      $.ajax({
        url: '/api/items_image/image',
        type: 'POST',
        data: img,
        dataType: 'html',
        processData: false,
        contentType: false
      })
      .done(function(html) {
        $(html).insertBefore($('#image-previews-container').children('label'));
        modifyUploader(count);
        image_ids.push($(html).attr('data-id'));
        $('#image_ids').val(image_ids);
        count += 1;
      })
      .fail(function() {
        alert('sorry, failed');
      })
    })
    $(this).val('');
  })
  
  $('.items-image-upload__dropbox').on('click', '.sell-upload-item__button--delete', function(e) {
    e.preventDefault();
    var li = $(this).parents('.sell-upload-item');
    var id = li.attr('data-id');
    $.ajax({
      url: '/api/items_image/destroy',
      type: 'DELETE',
      data: { id: Number(id) },
      dataType: 'html'
    })
    .done(function() {
      li.remove();
      deleteImage(count);
      for(i=0; i < image_ids.length; i++) {
        if (id == image_ids[i]) {
          image_ids.splice(i, 1);
        }
      }
      $('#image_ids').val(image_ids);
      count -= 1;
    })
    .fail(function() {
      alert('sorry, failed')
    })
  })
})