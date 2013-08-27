// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
  $('#adminusers_table').dataTable({
      "bPaginate": false,
      "bLengthChange": false,
      "bFilter": false,
      "bInfo": false,
      "aaSorting": [[2,'asc'],[0,'asc']]
    });
});
