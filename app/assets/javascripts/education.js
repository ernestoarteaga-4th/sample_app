$(document).ready(function() {
  $("#educations_educ_degree_id_new").hide();

  $("#addButton").click(function() {
    if($("#educations_educ_degree_id").is(":visible")) {
      $("#educations_educ_degree_id").hide();
      $("#educations_educ_degree_id_new").show();
      $("#addButton").text('*');
    }

    else {
	  $("#educations_educ_degree_id").show();
      $("#educations_educ_degree_id_new").hide();
      $("#addButton").text('+');
      $("#educations_educ_degree_id_new").val('');
    }
  });
});
