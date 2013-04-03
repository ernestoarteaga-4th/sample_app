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
      if @candidate.resume.resume_details.new(params[:resume_details]).save
        flash.now[:success] = "Summary was saved successfully."
      else
        flash.now[:notice] = "An error occurred while the system save the summary. Please try again."
      end
    else
      @candidate = Candidate.find(params[:id])
      if @candidate.resume.nil?
        @resume = @candidate.build_resume
        @resume.save
      end
      #@resume_details = ResumeDetail.new
    end
  end
  
  def experience
    @candidate = Candidate.find(params[:id])
    if @candidate.resume.nil?
      @resume = @candidate.build_resume
      @resume.save
    end
    @experience_items = @candidate.resume.experiences
  end
   
  def photo
    @candidate = Candidate.find(params[:id])
    @error = @candidate.errors
    
    if request.post?
      if @candidate.update_attributes(params[:candidate])
        flash[:success] = "Photo updated."
      else
        flash[:notice] = "An error occurred while the system save the photo. Please try again."
      end
    end
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
