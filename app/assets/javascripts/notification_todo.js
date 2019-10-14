$(function() {
  var todoNotificationTabs = $('#todo-notification');
  $(todoNotificationTabs.children()).on('click', function(e) {
    console.log(location.pathname)
    if (location.pathname != '/mypage') {
      return
    }
    e.preventDefault();
    var activeTab = todoNotificationTabs.children('.active');
    activeTab.removeClass('active');
    $(this).addClass('active');
    var index = $(todoNotificationTabs.children()).index($(this))
    $('#todo-notification-contents').children('.active').removeClass('active');
    $(`#todo-notification-contents ul:eq(${index})`).addClass('active');
  })
})