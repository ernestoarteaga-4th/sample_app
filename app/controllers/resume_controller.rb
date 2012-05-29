class ResumeController < ApplicationController

  def summary
    if request.post?
      @user = User.find(params[:id])
      @user.resume.summary = params[:user][:resume][:summary]
      if @user.resume.save
        flash.now[:success] = "Summary was saved successfully."
      else
        flash.now[:notice] = "An error occurred while the system save the summary."
      end
    else
      @user = User.find(params[:id])
      @error = @user.errors
      
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

end
