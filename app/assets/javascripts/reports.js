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
      $("#date_processing_from").removeAttr('disabled');
      $("#date_processing_to").removeAttr('disabled');
      $("#hire_date").removeAttr('disabled');
      $("#start_date").removeAttr('disabled');
    }

    else {
      $("#date_processing_from").attr('disabled', 'disabled');
      $("#date_processing_to").attr('disabled', 'disabled');
      $("#hire_date").attr('disabled', 'disabled');
      $("#start_date").attr('disabled', 'disabled');
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

$(document).ready(function() {
  $('#summaryForm').submit(function(e) { 
    var $input = $('#candidate_prof_summary_summary');
    var flag = false;

    if($input.val().length >= 150) {
      e.submit();
    }

    else {
      alert("You have to capture at least 150 characters in the summary");
      e.preventDefault();
    }
    
    return false;
  });
});