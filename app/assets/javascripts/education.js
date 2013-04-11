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


$(document).ready(function() {
$('#newEducationForm').submit(function(e) { 
     //se traen todos los inputs del formulario
     var $inputs = $('#newEducationForm :input');

 var obj = array.filter(function (inputs) {
        return inputs.id === 'education_date_out_3i';
    });
    //filter returns an array, and we just want the matching item



alert(obj[0]);

e.preventDefault(); // Cancel the submit

            return false; // Exit the .each loop

/*
     $inputs.each(function() {
        var encontro_error = validar($(this)); //uses dependence ok
        if (encontro_error){
            $.scrollTo( 'input#'+$(this).attr('id'), 800 ); //go to error
            e.preventDefault(); // Cancel the submit
            return false; // Exit the .each loop
        }
     });
*/
});
});