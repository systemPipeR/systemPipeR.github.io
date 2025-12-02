function loadLogo(img_src) {
  $('#svg-logo').load(img_src, function(){
   $('a[id^="cover"]')
   .removeAttr("style")
   .on("mouseover", function(){
      $('a[id^="cover"]').addClass("logo-blur");
      $(this).removeClass("logo-blur");
      $("#td-cover-block-0").addClass("bg-blur");
   })
   .on("mouseleave", function(){
      $("#td-cover-block-0").removeClass("bg-blur");
      $('a[id^="cover"]').removeClass("logo-blur");
   });

})
}


