class CandidateProfilesController < ApplicationController
  def new
  end

  def index
    
    id = params[:id] unless params.blank?
    if !current_candidate.admin_flag.nil?
      @candidate  = Candidate.find(params[:candidate_id])
      @error = @candidate.errors
    else
      @candidate = Candidate.find(current_candidate.id)
      @error  = current_candidate.errors
    end
    @total_candidate_profiles = @candidate.candidates_profiles
    #@total_candidate_profiles = CandidateProfile.all
  end

  def create
    @candidateprofile = CandidatesProfile.new(params[:candidateprofile])
    id = params[:candidate_id] unless params.blank?
    if !current_candidate.admin_flag.nil?
      @candidateprofile.candidate_id = id
      @error  = current_candidate.errors
    else
      @candidateprofile.candidate_id = current_candidate.id
      @error = @candidate.errors
    end

	
	#@candidateprofile.candidate_id = params[:candidate_id]
    
	@candidateprofile.save          

	@error = @candidateprofile.errors.full_messages.to_sentence
    logger.debug @error

    if !current_candidate.admin_flag.nil?
      #is admin
      redirect_to File.join('/candidates/', id.to_s(), '/candidate_profiles')
    else
      #not an admin
      redirect_to File.join('/candidates/', current_candidate.id.to_s(), '/candidate_profiles')
    end

  end

  def edit
    @candidates_profile  = CandidatesProfile.find(params[:id])
    @total_candidate_profile_tags = @candidates_profile.candidate_profile_tags

    @candidate  = Candidate.find(params[:candidate_id])
    @total_projects = @candidate.projects
  end

  def update
    @candidate = current_candidate
    
    if request.post?
      @candidate = Candidate.find(params[:id])
      @profile = CandidatesProfile.find(params[:candidate_profile_id])
      @profile.update_attributes(params[:profile])
      if @profile.save
        ##redirect_to File.join('/candidates/', current_candidate.id.to_s(), '/candidate_profiles')
        flash[:success] = "Candidate Profile was saved successfully."
      else
        flash[:notice] = "An error occurred while the system save the candidate profile."
      end
    else
      @profile = CandidatesProfile.find_by_id(params[:candidate_profile_id])
      @error = @profile.errors
    end 
  end   

  def delete
    CandidatesProfile.delete(params[:candidate_profile_id])
    @candidate  = Candidate.find(params[:candidate_id])
    render :index
  end

  def update_tags
    CandidateProfileTag.where(:candidates_profile_id => params[:id]).destroy_all

    if !params[:projects_tags_id].nil?
      params[:projects_tags_id].each do |t|
          @relation = CandidateProfileTag.new
          @relation.candidates_profile_id =  params[:id]
          @relation.project_tags_id = t.to_i
          @relation.save
      end
    end

    redirect_to File.join('/candidates/', current_candidate.id.to_s(), '/candidate_profiles/' + params[:id] + '/edit')
  end

end
