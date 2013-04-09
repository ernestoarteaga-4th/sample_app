$(document).ready(function() {
  $("#education_educ_degree_id_new").hide();

  $("#addButton").click(function() {
    if($("#education_educ_degree_id").is(":visible")) {
      $("#education_educ_degree_id").hide();
      $("#education_educ_degree_id_new").show();
      $("#addButton").text('*');
    }

    else {
	  $("#education_educ_degree_id").show();
      $("#education_educ_degree_id_new").hide();
      $("#addButton").text('+');
      $("#education_educ_degree_id_new").val('');
    }
  });
});
