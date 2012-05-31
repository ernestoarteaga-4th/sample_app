class ExperiencesController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user
  
  def show
  end
  
  def skill
    @user = User.find(params[:id])  
    @experience = @user.resume.experiences.find(params[:experience_id])
    if request.post?
       @flag = params[:skill_id][:id]
       if @experience.skills.find_by_id(@flag).nil? && !@flag.empty?
         if @experience.tools.new(:skill_id => @flag).save
           flash.now[:success] = "Tool was saved successfully."
         else
           flash.now[:notice] = "An error occurred while the system save the tool."
         end
       else
         flash.now[:notice] = "You tried to save a exists or empty Tool in this project. Please choose another and try again."
       end
    end
  end
  
  def new
    @user = current_user
    if request.post?
      @user = User.find(params[:id])
      if @user.resume.nil?
        @resume = @user.build_resume
        @resume.save
      else
        @resume = @user.resume
      end
      @experience = @resume.experiences.build(params[:experience])
      if @experience.save
        flash[:success] = "Experience was saved successfully."
      else
        flash[:notice] = "An error occurred while the system save the experience."
      end
    end
  end
  
  def destroy
    Experience.find(params[:id]).destroy
    redirect_to request.referer
  end
  
  private 
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
  
end
