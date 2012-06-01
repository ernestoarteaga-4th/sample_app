class ResumeController < ApplicationController

  def index
    @user = User.find(params[:id])
    if @user.resume.nil?
      @user.build_resume.save
    end
  end
  
  def summary
    if request.post?
      @user = User.find(params[:id])
      if @user.resume.resume_details.new(params[:resume_details]).save
        flash.now[:success] = "Summary was saved successfully."
      else
        flash.now[:notice] = "An error occurred while the system save the summary. Please try again."
      end
    else
      @user = User.find(params[:id])
      if @user.resume.nil?
        @resume = @user.build_resume
        @resume.save
      end
    end
  end
  
  def experience
    @user = User.find(params[:id])
    if @user.resume.nil?
      @resume = @user.build_resume
      @resume.save
    end
    @experience_items = @user.resume.experiences
  end
   
  def photo
    @user = User.find(params[:id])
    @error = @user.errors
    
    if request.post?
      if @user.update_attributes(params[:user])
        flash[:success] = "Photo updated."
      else
        flash[:notice] = "An error occurred while the system save the photo. Please try again."
      end
    end
  end
  
  def education
    if request.post?
      @user = User.find(params[:id])
      @total_educations = @user.resume.educations
      @education =  @user.resume.educations.new(params[:education])
      @error = @education.errors
      if @education.save
        flash[:success] = "Education was saved successfully."      
      end
    else
      @user = User.find(params[:id])
      @error = @user.errors
      @total_educations = @user.resume.educations
    end
  end
end
