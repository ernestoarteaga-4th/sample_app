// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
(function($){
window.CandidateCertification = {
	start: function(){
		var txtCertificationName, chBoxNotInList;
		txtCertificationName = $("#certification_name[type=text]");
		chBoxNotInList = $("#certification_chBNotInList");
		txtCertificationName.attr("disabled",true);
		chBoxNotInList.click(function(){
			if(chBoxNotInList.is(":checked")){
				txtCertificationName.attr("disabled",false);
			}
			else{
				txtCertificationName.attr("disabled",true);
			}
		});
	}

};

})(jQuery);

$(document).ready(function(){
	CandidateCertification.start();
});	
