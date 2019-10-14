$(function() {
  var parchaseTabs = $('#parchase');
  $(parchaseTabs.children()).on('click', function(e) {
    if (location.pathname != '/mypage') {
      return
    }
    e.preventDefault();
    var activeTab = parchaseTabs.children('.active');
    activeTab.removeClass('active');
    $(this).addClass('active');
    var index = $(parchaseTabs.children()).index($(this))
    $('#parchase-contents').children('.active').removeClass('active');
    $(`#parchase-contents ul:eq(${index})`).addClass('active');
  })
})