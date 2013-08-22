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
