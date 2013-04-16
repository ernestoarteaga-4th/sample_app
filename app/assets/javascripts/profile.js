(function($){
	window.Profile = {
		start: function(){
			var chBHasVisa = $("#candidate_has_visa"), chBHasPassport = $("#candidate_has_passport"),
			    chBCurrentlyEmployed = $("#candidate_currently_employed"), _this = this; //This is for the whole object
		    
		    _this.checkBoxes(chBHasVisa,"#visaShowHide");
		    _this.checkBoxes(chBHasPassport,"#passportShowHide");
		    _this.checkBoxes(chBCurrentlyEmployed,".employedShowHide");

			chBHasVisa.click(function(){
				_this.checkBoxes($(this),"#visaShowHide");
			});
			chBHasPassport.click(function(){
				_this.checkBoxes($(this),"#passportShowHide");
			});
			chBCurrentlyEmployed.click(function(){
				_this.checkBoxes($(this),".employedShowHide");
			});
			
		},

		checkBoxes: function(checkBox, itemShowHide){
			if(checkBox.is(":checked")){
				$(itemShowHide).fadeIn();

			}
			else{
				$(itemShowHide).fadeOut();
			}
		}
	}
})(jQuery);