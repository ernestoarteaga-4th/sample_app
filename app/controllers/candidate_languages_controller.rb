class CandidateLanguagesController < ApplicationController
   before_filter :verifylogin
   def verifylogin
       if(current_candidate == nil)
        redirect_to root_url#, {:status=>403} todo make this status work :-/
      end
   end

   def index
    @candidate = current_candidate
    @error = @candidate.errors
    
    @total_languages = @candidate.candidate_languages
    @language = CandidateLanguage.new

  end
 
  def new
    @candidate = current_candidate
    @candidate_language = @candidate.candidate_languages.build(params[:candidate_language])
    language = Language.new 

     if (params[:language_notinlist])

          if(!params[:lang_name].empty?)
            language.name = params[:lang_name]
            language.save
          else
            flash[:notice] = "Please provide a valid language name"
            language = nil
          end

     else
       language = Language.find(params[:language_id])
     
     end
     @candidate_language.language = language
    if (language != nil )
      if @candidate_language.save
        flash[:success] = "languages was saved successfully."
      else
        language.destroy
        flash[:notice] = "An error occurred while the system save the languages#{@candidate_language.errors.as_json}"
      end
    end 
    redirect_to request.referer 
  end
  
  def destroy
    CandidateLanguage.find(params[:id]).destroy
    redirect_to request.referer
  end
end