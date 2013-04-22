$(document).ready(function() {
    $("#search_type_tag").change(function() {
      var state = $('select#search_type_tag :selected').val();
      if(state == "") state="0";
      jQuery.getJSON('/staff/1/report/search/?state=' + state, function(data){
          $("#search_category_textbox").val(data.message + data.state);
      })
      return false;
    });

})