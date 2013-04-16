(function($){
	window.Profile = {
		start: function(){
			var chBHasVisa = $("#candidate_has_visa"), chBHasPassport = $("#candidate_has_passport"),
			    chBCurrentlyEmployed = $("#candidate_currently_employed");
			chBHasVisa.click(function(){
				if(chBHasVisa.attr("checked")){
					chBHasVisa.attr("checked",false);
					$("#visaShowHide").fadeOut();
				}
				else{
					chBHasVisa.attr("checked",true);
					$("#visaShowHide").fadeIn();
				}
			});
			chBHasPassport.click(function(){
				if(chBHasPassport.attr("checked")){
					chBHasPassport.attr("checked",false);
					$("#passportShowHide").fadeOut();
				}
				else{
					chBHasPassport.attr("checked",true);
					$("#passportShowHide").fadeIn();
				}
			});
			chBCurrentlyEmployed.click(function(){
				if(chBCurrentlyEmployed.attr("checked")){
					chBCurrentlyEmployed.attr("checked",false);
					$(".employedShowHide").fadeOut();
				}
				else{
					chBCurrentlyEmployed.attr("checked",true);
					$(".employedShowHide").fadeIn();
				}
			});
			
		}
	}
})(jQuery);