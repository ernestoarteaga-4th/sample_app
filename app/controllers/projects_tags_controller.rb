class ProjectsTagsController < ApplicationController
  
  def new 
    @candidate = current_candidate
    @type = params[:type_id]
    
    case @type
      when "1"
        @tag_title = "Tool"
        @new_page = "projects_tags/new-tool"
      when "2"
        @tag_title = "Knowledge"
        @new_page = "projects_tags/new-knowledge"
      else
        @tag_title = "Technology"
        @new_page = "projects_tags/new-techology"
    end
    
    if request.post?
      @candidate = Candidate.find(params[:id])
      @project = @candidate.projects.find(params[:project_id])
      @projrole = @project.projroles.find(params[:projrole_id])
      @projtag = @projrole.projects_tags.build(params[:projtag])
      if @projtag.save
        flash[:success] = @tag_title + " was saved successfully."
        @projroles_items = @project.projroles
        render 'projects/show'
      else
        flash[:notice] = "An error occurred while the system save the "+@tag_title + "."
        render @new_page
      end
    else
      @candidate = Candidate.find(params[:id])
      @project = @candidate.projects.find(params[:project_id])
      @projrole  = @project.projroles.find(params[:projrole_id])
      @title = @tag_title + " for " + Role.find(@projrole.roles_id).name + " in " + @project.name
      @projtag = ProjectsTag.new
      @projtag.date_in = @projrole.date_in
      @projtag.date_out = @projrole.date_out
      @error = @projrole.errors
      render @new_page
    end
  end
  
  def destroy
    @candidate = Candidate.find(params[:id])
    @project = @candidate.projects.find(params[:project_id])
    @projrole = @project.projroles.find(params[:projrole_id])
    
    ProjectsTag.find(params[:projtag_id]).destroy
    @projroles_items = @project.projroles
    render 'projects/show'
  end
end
