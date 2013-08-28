// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
(function($){
	window.Application = {
		setSideBarHeight: function(){
			//alert("asd");
			var content = $("#content"), sidebar = $("#sidebar"), height, breadcrumbs = $("#breadcrumbs"), 
			subheader = $("img.subheader");
			height = breadcrumbs.height() +content.height() + 119;
			//alert("content.height"+content.height()+" sidebar.height" + subheader.height());
			sidebar.height(content.height());
			//alert("breadcrumbs"+breadcrumbs.height() + " content" + content.height());
			//alert("sidebar.height"+sidebar.height() + "height" + height);
		}
	}
})(jQuery);

jQuery(document).ready(function(){
	Application.setSideBarHeight();
	$('.dropdown-toggle').dropdown();
});


/*(function ($) {
    $.fn.showHide = function (options) {
 
    //default vars for the plugin
        var defaults = {
            speed: 1000,
            easing: '',
            changeText: 0,
            showText: 'Show',
            hideText: 'Hide'
 
        };
        var options = $.extend(defaults, options);
 
        $(this).click(function () {
// optionally add the class .toggleDiv to each div you want to automatically close
                      $('.toggleDiv').slideUp(options.speed, options.easing);
             // this var stores which button you've clicked
             var toggleClick = $(this);
             // this reads the rel attribute of the button to determine which div id to toggle
             var toggleDiv = $(this).attr('rel');
             // here we toggle show/hide the correct div at the right speed and using which easing effect
             $(toggleDiv).slideToggle(options.speed, options.easing, function() {
             // this only fires once the animation is completed
             if(options.changeText==1){
             $(toggleDiv).is(":visible") ? toggleClick.text(options.hideText) : toggleClick.text(options.showText);
             }
              });
 
          return false;
 
        });
 
    };
})(jQuery);*/


$(document).ready(function() {

	/*$('.show_hide').showHide({
        speed: 1000,  // speed you want the toggle to happen
        easing: '',  // the animation effect you want. Remove this line if you dont want an effect and if you haven't included jQuery UI
        changeText: 1, // if you dont want the button text to change, set this to 0
        showText: 'send Message',// the button text to show when a div is closed
        hideText: 'Close' // the button text to show when a div is open
 
    });*/
    $("#slidingDiv").hide();
    $("#send_message").on("click", function(){
        $("#emptyDiv, #slidingDiv").toggle();
    });

    $("#slidingDiv2").hide();
    $(".show_hide").on("click", function(){
        $("#can_id").val($(this).attr('id'));
        $("#emptyDiv2, #slidingDiv2").toggle();
        $("#reply_text").focus();
        $("#slidingDiv2").focus();
    });
    /*$("#message_button").click(function() {

      $.ajax({ 
            type: 'POST', 
            url: 'microposts',  
            
          });
	});*/

});
