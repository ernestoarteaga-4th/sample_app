class ProjrolesController < ApplicationController

  def new
    @candidate = current_candidate
    
    if request.post?
      @candidate = Candidate.find(params[:id])
      @project = @candidate.projects.find(params[:project_id])
      @projrole = @project.projroles.build(params[:projrole])
      if @projrole.save
        flash[:success] = "Project was saved successfully."
        @projroles_items = @project.projroles
        render 'projects/show'
      else
        flash[:notice] = "An error occurred while the system save the project."
      end
    else
      @candidate = Candidate.find(params[:id])
      @project = @candidate.projects.find(params[:project_id])
      @title = @project.name
      @projrole  = Projrole.new
      @error = @projrole.errors
    end
  end

  def show
    
  end

  def update
    @candidate = current_candidate
    
    if request.post?
      @candidate = Candidate.find(params[:id])
      @project = @candidate.projects.find(params[:project_id])
      @projrole = @project.projroles.find(params[:projrole_id])
      @projrole.update_attributes(params[:projrole])
      if @projrole.save
        flash[:success] = "Project was saved successfully."
        @projroles_items = @project.projroles
        render 'projects/show'
      else
        flash[:notice] = "An error occurred while the system save the project."
      end
    else
      @candidate = Candidate.find(params[:id])
      @project = @candidate.projects.find(params[:project_id])
      @projrole = @project.projroles.find(params[:projrole_id])
      @error = @project.errors
      @roles_items = Role.all
    end
  end
  
  def destroy
    @candidate = Candidate.find(params[:id])
    @project = @candidate.projects.find(params[:project_id])
    @projrole = @project.projroles.find(params[:projrole_id])
    Projrole.find(params[:projrole_id]).destroy
    @projroles_items = @project.projroles
    render 'projects/show'
  end
  
  private 
    def correct_candidate
      @candidate = Candidate.find(params[:id])
      redirect_to(root_path) unless current_candidate?(@candidate)
    end
    
end
