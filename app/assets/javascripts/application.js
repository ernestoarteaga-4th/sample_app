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

var succesfully_requested_micropost_data;

$(document).ready(function() {    
    succesfully_requested_micropost_data = true;
    $("#slidingDiv").hide();
    $("#send_message").on("click", function(){
        $("#emptyDiv, #slidingDiv").toggle();
    });

    $("#slidingDiv2").hide();
    $(".show_hide").on("click", function(){
        $("#can_id").val($(this).attr('id'));
        $("#emptyDiv2, #slidingDiv2").toggle();
        $("#reply_text").focus();        
    });

    var container;
    var refreshContent;

    $("#AdminFeeds").hide();

    jQuery('#select_follower').change(function(){
      feed_admin_microposts(this.value);
    });

    jQuery('#onlyMyPosts').click(function(){
      feed_admin_microposts(jQuery('#select_follower').val());
    });
});


function feed_admin_microposts(select_value){
  strin1 = 'feed_admin/';
  onlymine = 0;
  current_page = select_value;  
  if (current_page && succesfully_requested_micropost_data){    
    succesfully_requested_micropost_data = false;
    jQuery('#onlyMyPosts').attr('disabled', 'disabled');
    jQuery('#select_follower').attr('disabled', 'disabled');
    jQuery('#AdminFeeds').stop().animate({opacity: 0}, 200, function(){
      jQuery('#AdminFeeds').animate({height: '0px'}, 600, function(){        
        if($('#onlyMyPosts').is(':checked')){
          onlymine = 1;
        }
        jQuery.ajax({
          type: "POST",
          dataType: 'json',
          data: {solomicro: onlymine, user_followed: current_page},
          url: strin1.concat(current_page), 
          success: function (response) {            
            table_microposts = '<table id="microposts" class="microposts" style="opacity:0;height:\'0px\'">';

            jQuery.each(response,function(k,v){
              table_microposts += '<tr class="feed-content">' 
              + '<td class="gravatar"><a href=/candidate/' + v.micropost.created_by  + '>'
              + '<img alt="Gravatar" class="gravatar" height="50" src="http://gravatar.com/avatar/c2600ff37ef837584fd976599dded22d?size=50" width="50" />'
              + '</a></td>'
              + '<td class="micropost"><span class="candidate"><a href=/candidates/' + v.micropost.created_by  
              + '>' + v.micropost.first_name +'</a></span>'
              + '<span class="content">'
              + v.micropost.content
              + '</span>'
              + '<span class="timestamp">'
              + 'Posted '
              + jQuery.timeago(v.micropost.created_at)
              + '</span>'
              + '</td>'
              + '<td class="micropost-delete">'
              + '<label class="show_hide" for="reply" id="' + v.micropost.candidate_id
              + '" rel="#slidingDiv2">'
              + '<span class="translation_missing" title="Replying the message">Reply</span>'
              + '</label>';

              if ($("#current_id").val() == v.micropost.created_by){
                table_microposts += '<a href=/microposts/' + v.micropost.id
                      + ' data-confirm="You sure?" data-method="update" rel="nofollow"'
                      + ' title="Removing the message">Remove</a>'
                      + '</td></tr>';
              }
              else{
                table_microposts += '</td>' 
                                  + '</tr>';
              }
            });
            table_microposts += '</table><br>';

            jQuery('#AdminFeeds').show();
            jQuery('#AdminFeeds').empty();                  
            jQuery('#AdminFeeds').append(table_microposts);
            
            feedsSize = jQuery('#microposts').css('height');            
            $(".show_hide").bind("click", function(){
                $("#can_id").val($(this).attr('id'));
                $("#emptyDiv2, #slidingDiv2").toggle();
                $("#reply_text").focus();
            });
            jQuery('#AdminFeeds').animate({height: feedsSize}, 600, function(){
              jQuery('#AdminFeeds').animate({opacity: 1}, 50, function(){
                jQuery('#microposts').animate({opacity:1}, 200);                
              });
            }); 

            $("#microposts").tablePagination({});

          },fail: function (jqXHR, textStatus) {            
            jQuery('#onlyMyPosts').removeAttr('disabled');
            jQuery('#select_follower').removeAttr('disabled');
            succesfully_requested_micropost_data = true;
          },complete: function () {                    
            $("#AdminFeeds").show();
            succesfully_requested_micropost_data = true;
            jQuery('#onlyMyPosts').removeAttr('disabled');
            jQuery('#select_follower').removeAttr('disabled');
          }
        });
      });
    });      
  }
  else{
    $("#AdminFeeds").hide();
  }
}
