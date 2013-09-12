//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .

//点击回复，生成@
$(function(){
  $(document).on('click', '.at', function() {
    var $textarea = $('#new_comment textarea');
    $textarea.focus().val($textarea.val() + '@' + $(this).data('user-name') + ' ');
    event.preventDefault();
  });
})
