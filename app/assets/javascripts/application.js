//= require jquery
//= require jquery_ujs
//= require kindeditor
//= require bootstrap
//= require_tree .

//点击回复，生成@
$(function(){
  $(document).on('click', '.at', function() {
   // var $textarea = $('#new_comment textarea');
	 document.location='#new_comment';
    comment_editor.html(comment_editor.html()+'['+'回应' + '@' + $(this).data('user-name') + ' '+']'+'  ');
    event.preventDefault();
  });
})
	

// $(function(){
// $(window).scroll(function(){  //只要窗口滚动,就触发下面代码 
// var scrollt = document.documentElement.scrollTop + document.body.scrollTop; //获取滚动后的高度 
// if( scrollt >200 ){  //判断滚动后高度超过200px,就显示  
// $('<a id="gotop" href="#"><img src="/assets/gotop.png"></a>').appendTo('body');
// }else{      
// $('a').remove('#gotop');
// }
// });
// $("#gotop").click(function(){ //当点击标签的时候,使用animate在200毫秒的时间内,滚到顶部
// $("html,body").animate({scrollTop:"0px"},300);
// });
// });
//插入图片
//$(function(){
  //$(document).on('click', '.insertpicture', function() {
    //var $textarea = $('#new_comment textarea');
    //$textarea.focus().val($textarea.val() + ' ' + '!'+'['+']'+'('+')');
    //event.preventDefault();
  //});
//})
