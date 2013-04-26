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

$(document).ready(function() {
  $("#recruitingProcess").click(function() {
    if(this.checked) {
      $("#search_date_processing_from_2i").removeAttr('disabled');
      $("#search_date_processing_from_3i").removeAttr('disabled');
      $("#search_date_processing_from_1i").removeAttr('disabled');
      $("#search_date_processing_to_2i").removeAttr('disabled');
      $("#search_date_processing_to_3i").removeAttr('disabled');
      $("#search_date_processing_to_1i").removeAttr('disabled');
    }

    else {
      $("#search_date_processing_from_2i").attr('disabled', 'disabled');
      $("#search_date_processing_from_3i").attr('disabled', 'disabled');
      $("#search_date_processing_from_1i").attr('disabled', 'disabled');
      $("#search_date_processing_to_2i").attr('disabled', 'disabled');
      $("#search_date_processing_to_3i").attr('disabled', 'disabled');
      $("#search_date_processing_to_1i").attr('disabled', 'disabled');
    }
  });         
});

$(document).ready(function() {
  $("#isRecruited").click(function() {
    if(this.checked) {
      $("#search_hire_date_2i").removeAttr('disabled');
      $("#search_hire_date_3i").removeAttr('disabled');
      $("#search_hire_date_1i").removeAttr('disabled');
      $("#search_start_date_2i").removeAttr('disabled');
      $("#search_start_date_3i").removeAttr('disabled');
      $("#search_start_date_1i").removeAttr('disabled');
      $("#search_recruited_date_2i").removeAttr('disabled');
      $("#search_recruited_date_3i").removeAttr('disabled');
      $("#search_recruited_date_1i").removeAttr('disabled');
      $("#search_placeAssignment").removeAttr('disabled');
      $("#search_office_id").removeAttr('disabled');
    }

    else {
      $("#search_hire_date_2i").attr('disabled', 'disabled');
      $("#search_hire_date_3i").attr('disabled', 'disabled');
      $("#search_hire_date_1i").attr('disabled', 'disabled');
      $("#search_start_date_2i").attr('disabled', 'disabled');
      $("#search_start_date_3i").attr('disabled', 'disabled');
      $("#search_start_date_1i").attr('disabled', 'disabled');
      $("#search_recruited_date_2i").attr('disabled', 'disabled');
      $("#search_recruited_date_3i").attr('disabled', 'disabled');
      $("#search_recruited_date_1i").attr('disabled', 'disabled');
      $("#search_placeAssignment").attr('disabled', 'disabled');
      $("#search_office_id").attr('disabled', 'disabled');
    }
  });         
});

$(document).ready(function() {
  $('#reportSearchForm').submit(function(e) { 
    var $inputs = $('#reportSearchForm :input');
    var flag = true;

    if(flag) {
      e.submit();
    }

    else {
      e.preventDefault();
    }
    
    return false;
  });
});