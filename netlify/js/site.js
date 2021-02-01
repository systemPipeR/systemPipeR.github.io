/* -------------------------- Custom site JS -------------------------------*/

$(function(){
  // hover dropdown open animation
  $('.nav-item')
    .hover(function(){
      $(this).children('.dropdown-menu').stop().slideDown(250);
    })
    .on('mouseleave', function(){
      $(this).children('.dropdown-menu').stop().slideUp(250);
    });

    // toc and sidebar
    var mainSize = 8;
    $('#sidebarSwitch').click(function(){
      if ($(this).is(':checked')){
        mainSize -= 2;
        $('.td-main .td-sidebar').show();
      } else {
        mainSize += 2;
        $('.td-main .td-sidebar').hide();
      }
      $('body main').attr('class', `col-12 col-md-9 col-xl-${mainSize} pl-md-5`);
    });

    $('#tocSwitch').click(function(){
      if ($(this).is(':checked')){
        mainSize -= 2;
        $('.td-main .td-toc').attr('style','display:block !important');
      } else {
        mainSize += 2;
        $('.td-main .td-toc').attr('style','display:none !important');
      }
      $('body main').attr('class', `col-12 col-md-9 col-xl-${mainSize} pl-md-5`);
    });
});
