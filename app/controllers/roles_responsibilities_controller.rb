class RolesResponsibilitiesController < ApplicationController
  
  def new
    @candidate = current_candidate
    
    if request.post?
      @candidate = Candidate.find(params[:id])
      @project = @candidate.projects.find(params[:project_id])
      @projrole = @project.projroles.find(params[:projrole_id])
      @rolerespon = @projrole.roles_responsibilities.build(params[:rolerespon])
      if @rolerespon.save
        flash[:success] = "Project was saved successfully."
        @projroles_items = @project.projroles
        render 'projects/show'
      else
        flash[:notice] = "An error occurred while the system save the project."
      end
    else
      @candidate = Candidate.find(params[:id])
      @project = @candidate.projects.find(params[:project_id])
      @projrole  = @project.projroles.find(params[:projrole_id])
      @title = @project.name + " " + Role.find(@projrole.roles_id).name
      @rolerespon = RolesResponsibilitie.new
      @error = @projrole.errors
    end
  end

end
