class CandidateProfilesController < ApplicationController
  def new
  end

  def index
    @candidate  = Candidate.find(params[:candidate_id])
    @total_candidate_profiles = @candidate.candidates_profiles
    #@total_candidate_profiles = CandidateProfile.all
  end

  def create
  	logger.debug "****** **********************************"
	@candidateprofile = CandidatesProfile.new(params[:candidateprofile])
	@candidateprofile.candidate_id = params[:candidate_id]
    
	@candidateprofile.save          

	@error = @candidateprofile.errors.full_messages.to_sentence
    logger.debug @error

    redirect_to File.join('/candidates/', current_candidate.id.to_s(), '/candidate_profiles')
  end

  def edit
    @candidate = Candidate.find(params[:id])
    
    @candidate.projects.each do |projects|
      projects.projects_roles.each do |projects_roles|
        projects_roles.projects_tags.each do |projects_tags|
          puts projects_tags.id
        end
      end
    end
  end

  def delete
    CandidatesProfile.delete(params[:candidate_profile_id])
    @candidate  = Candidate.find(params[:candidate_id])
    render :index
  end

end
