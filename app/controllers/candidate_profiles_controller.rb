class CandidateProfilesController < ApplicationController
  def new
  end

  def index
    @candidate  = Candidate.find(params[:candidate_id])
    @total_candidate_profiles = @candidate.candidate_profiles
    #@total_candidate_profiles = CandidateProfile.all
  end

  def create
  	logger.debug "****** **********************************"
	@candidateprofile = CandidateProfile.new(params[:candidateprofile])
	@candidateprofile.candidate_id = params[:candidate_id]
    
	@candidateprofile.save          

    #if @candidatesprofile.save          
    #  redirect_to root_path
    #else
    #  redirect_to root_path
    #end  	

	@error = @candidateprofile.errors.full_messages.to_sentence
    logger.debug @error
  end

end
