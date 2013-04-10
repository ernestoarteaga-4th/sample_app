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
			if(chBoxNotInList.attr("checked")){
				chBoxNotInList.attr("checked",false);
				txtCertificationName.attr("disabled",true);
			}
			else{
				chBoxNotInList.attr("checked",true);
				txtCertificationName.attr("disabled",false);
			}
		});
	}

};

})(jQuery);

$(document).ready(function(){
	CandidateCertification.start();
});	
