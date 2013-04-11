class ResumeController < ApplicationController

  def index
    @candidate = Candidate.find(params[:id])
    if @candidate.resume.nil?
      @candidate.build_resume.save
    end
  end
  
  def summary
    if request.post?

      @candidate = Candidate.find(params[:id])
      #resume_details = ResumeDetail.new
      #details = params[:resume_detail]
      #logger.debug "********* #{details} ************"
      #resume_details.summary = details[:summary]
      #resume_details.resume_id = @candidate.resume.id
      #if resume_details.save
      if @candidate.candidate_prof_summary.new(params[:candidate_prof_summary]).save
        flash.now[:success] = "Summary was saved successfully."
      else
        flash.now[:notice] = "An error occurred while the system save the summary. Please try again."
      end
    else
      @candidate = Candidate.find(params[:id])
      #if @candidate.resume.nil?
        #@resume = @candidate.build_resume
        #@resume.save
      #end
      #@resume_details = ResumeDetail.new
    end
  end
  
  def project
    @candidate = Candidate.find(params[:id])
    if @candidate.resume.nil?
      @resume = @candidate.build_resume
      @resume.save
    end
    @project_items = @candidate.resume.projects
  end
   

  
  def education
    if request.post?
      @candidate = Candidate.find(params[:id])
      @total_educations = @candidate.resume.educations
      @education =  @candidate.resume.educations.new(params[:education])
      @error = @education.errors
      if @education.save
        flash[:success] = "Education was saved successfully."      
      end
    else
      @candidate = Candidate.find(params[:id])
      @error = @candidate.errors
      @total_educations = @candidate.resume.educations
    end
  end
end
