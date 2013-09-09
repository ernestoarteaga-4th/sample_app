$(document).ready(function() {
   $( "#follow_button" ).button({
    icons: {
      primary: "ui-icon-triangle-1-s"
    }
  });

  if($("#follow_button").val()=='Follow')
    $("#send_message").hide();

  $("#follow_button").click(function() {
    if($("#follow_button").val()=='Follow'){
      //jQuery("a#send_message").removeAttr('style');
      
      $("#follow_button").text('Unfollow');
      $("#follow_button").val('Unfollow');
      $("#send_message").show();

      $.ajax({ 
            type: 'POST', 
            url: 'followings',  
            /*complete: function(){
              alert("Following");
            }*/
            
          });

      
    }
    else{
      $("#follow_button").text('Follow');
      $("#follow_button").val('Follow');
      $("#send_message").hide();

      $.ajax({ 
            type: 'POST', 
            url: 'unfollow',  
            
          });

      
      
    }
  });
});