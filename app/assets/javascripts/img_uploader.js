$(function(){
  var count = 0;
  function buildItem(readerResult) {
    var html =
    `
    <li class='sell-upload-item'>
      <figure class='sell-upload-item__figure'>
      <img src=${readerResult} class='sell-upload-item__image'>
      </figure>
      <div class='sell-upload-item__button'>
        <a class='sell-upload-item__button--edit'>
          編集
        </a>
        <a class='sell-upload-item__button--delete'>
          削除
        </a>
      </div>
    </li>
    `
    return html
  }
  function buildInput(count) {
    var input = 
    `
    <input  class="items-image-upload__hidden active-input"
            type="file" name="item[images_attributes][${count}][name]"
            id="item_images_attributes_${count}_name">
    `
    return input
  }

  $('.items-image-upload__dropbox').on('change drop', `.active-input`, function(e) {
    var file = e.target.files[0];
    var reader = new FileReader();
    reader.onload = function() {
      var html = buildItem(reader.result)
      $(html).insertBefore($('#image-previews-container').children('label'))
    }
    reader.readAsDataURL(file);
    $(this).removeClass('active-input');
    if (count < 4) {
      $(`.items-image-upload__label-has${count}`)
      .removeClass(`items-image-upload__label-has${count}`)
      .addClass(`items-image-upload__label-has${count+1}`)
      .attr('for', `item_images_attributes_${count+1}_name`)
      .append(buildInput(count+1))
    } else if (count == 4) {
      $(`.items-image-upload__label-has${count}`)
      .removeClass(`items-image-upload__label-has${count}`)
      .addClass(`items-image-upload__label-has0`)
      .attr('for', `item_images_attributes_${count+1}_name`)
      .append(buildInput(count+1))
    } else if (count > 4 && count < 9) {
      $(`.items-image-upload__label-has${count-5}`)
      .removeClass(`items-image-upload__label-has${count-5}`)
      .addClass(`items-image-upload__label-has${count-4}`)
      .attr('for', `item_images_attributes_${count+1}_name`)
      .append(buildInput(count+1))
    } else if (count == 9) {
      $(`.items-image-upload__label-has${count-5}`)
      .removeClass(`items-image-upload__label-has${count-5}`)
      .addClass(`items-image-upload__label-hasmax`)
    }
    count += 1
  })
})