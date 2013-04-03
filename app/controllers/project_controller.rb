class ProjectController < ApplicationController
  before_filter :authenticate
  before_filter :correct_candidate
  
  def index
    @candidate  = Candidate.find_by_id(params[:id])
    #@microposts = @candidate.microposts.paginate(:page => params[:page])
    #@title = @candidate.first_name

    if @candidate.resume.nil?
      @resume = @candidate.build_resume
      @resume.save
    end
    #@title = @candidate.resume.id

    if @candidate.resume.projects.nil?
      @project_items = @candidate.resume.build_projects
      @project_items.save
      @title = "Nulo"
    else
      @project_items = @candidate.resume.projects
      @title = "Lleno"
    end
    
  end

  def show
  end
  
  def skill
    @candidate = Candidate.find(params[:id])  
    @project = @candidate.resume.projects.find(params[:project_id])
    if request.post?
       @flag = params[:skill_id][:id]
       if @project.skills.find_by_id(@flag).nil? && !@flag.empty?
         if @project.tools.new(:skill_id => @flag).save
           flash.now[:success] = "Project was saved successfully."
         else
           flash.now[:notice] = "An error occurred while the system save the project."
         end
       else
         flash.now[:notice] = "You tried to save a exists or empty Project in this project. Please choose another and try again."
       end
    end
  end
  
  def new
    @candidate = current_candidate
    if request.post?
      @candidate = Candidate.find(params[:id])
      if @candidate.resume.nil?
        @resume = @candidate.build_resume
        @resume.save
      else
        @resume = @candidate.resume
      end
      @project = @resume.projects.build(params[:project])
      if @project.save
        flash[:success] = "Project was saved successfully."
      else
        flash[:notice] = "An error occurred while the system save the project."
      end
    end
  end
  
  def destroy
    Project.find(params[:id]).destroy
    redirect_to request.referer
  end
  
  private 
    def correct_candidate
      @candidate = Candidate.find(params[:id])
      redirect_to(root_path) unless current_candidate?(@candidate)
    end

end
