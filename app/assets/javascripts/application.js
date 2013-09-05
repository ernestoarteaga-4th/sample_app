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
        //$("#slidingDiv2").focus();
    });


    /*$("#message_button").click(function() {

      $.ajax({ 
            type: 'POST', 
            url: 'microposts',  
            
          });
	});*/
    var container;
    var refreshContent;

    $("#AdminFeeds").hide();
    jQuery('#select_follower').change(function(){
        /*var strin1 = 'feed_admin/'
        jQuery.ajax({ 
            type: 'POST', 
            url:  strin1.concat(this.value),  
            success: function(){
              
              alert(jQuery('#select_follower'));
              container = $('#AdminFeeds');
              container.innerHTML = refreshContent;
              refreshContent = container.innerHTML;
              //jQuery('#div').html(response);
              $("#AdminFeeds").show();
              
            }
          });*/
        var strin1 = 'feed_admin/'

        if (this.value){
          jQuery.ajax({
            type: "POST",
            dataType: 'json',
            url: strin1.concat(this.value), 
            //data: { hname : hname },
            success: function (response) {

              var table_microposts = '<table id="microposts" class="microposts">';
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
                /*table_microposts += '%tr.feed-content'
                                  +    '- admin_candidate = Candidate.find(' + v.micropost.created_by + ')'
                                  +    '%td.gravatar'
                                  +      '= link_to gravatar_for(admin_candidate), admin_candidate' 
                                  +    '%td.micropost' 
                                  +      '%span(class="candidate")'
                                  +        '= link_to admin_candidate.first_name, admin_candidate' 
                                  +      '%span(class="content")'
                                  +        '= '+v.micropost.content
                                  +      '%span(class="timestamp")'
                                  +        'Posted' 
                                  +        '= time_ago_in_words('+v.micropost.created_at+')'
                                  +        'ago.'
                                  +    '- if current_candidate?('+v.micropost.candidate+')' 
                                  +      '%td.micropost-delete'
                                  +        '- @value = "/reply/#{'+v.micropost.created_by+'}"'
                                  +        '= label_tag :reply, t("reply"), :id => "#{'+v.micropost.created_by+'}", :class=>"show_hide", :rel=>"#slidingDiv2"'
                                  +        '- if (current_candidate.id == '+v.micropost.created_by+')'
                                  +          '= link_to "Remove", '+v.micropost+', :method => :update, :confirm => "You sure?", :title =>'+ v.micropost.content
                */

              });
              table_microposts += '</table><br>';
              //console.log(table_microposts);
              jQuery('#AdminFeeds').show();
              jQuery('#AdminFeeds').empty();
              jQuery('#AdminFeeds').append(table_microposts);

              $(".show_hide").bind("click", function(){
                $("#can_id").val($(this).attr('id'));
                $("#emptyDiv2, #slidingDiv2").toggle();
                $("#reply_text").focus();
              });

            },
            fail: function (jqXHR, textStatus) {
              alert(textStatus);
            },
            complete: function () {
              //alert("completed");
              $("#AdminFeeds").show();
            }
          });
        }
        else{
          $("#AdminFeeds").hide();
        }
        
        
    });

});

function validatePassword(password){
    var passwordRegex = new RegExp("^.(?=.{6,12})(?=.*[a-zA-Z])(?=.*\d)(?=.*[!#$%&? \"]).$");

    if(passwordRegex.test(password)){
        jQuery('#')
    }else{

    }

    return passwordRegex.test(password);
}
