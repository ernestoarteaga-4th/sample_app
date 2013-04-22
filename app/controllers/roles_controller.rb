class RolesController < ApplicationController
  
  def index
    @roles = Role.all
  end

  def new
    if request.post?
      @role = Role.new(params[:role])
      @cat_role_rows = Role.where("name = ?", @role.name)
      if @cat_role_rows.length > 0
        flash[:notice] = "The Role already exists"
      else
        @role.approved_flag = true
        @role.approved_by = current_candidate.first_name + " " + 
                              current_candidate.middle_name + " " + 
                              current_candidate.first_last_name + " " + 
                              current_candidate.second_last_name
        @role.save
        @roles = Role.all
        render 'index'
      end
    else
      @role = Role.new
    end
  end

  def action
    @roles = Role.all

    if(params[:update_button] != nil)
      @roles.each do |row|
        @role = params["approved_flag_" + row.id.to_s()]
        row.approved_by = current_candidate.first_name + " " + 
                          current_candidate.middle_name + " " + 
                          current_candidate.first_last_name + " " + 
                          current_candidate.second_last_name

        if(@role == nil)
          Role.update(row.id, 
                          :approved_flag => false,
                          :approved_by => row.approved_by)
        else
          Role.update(row.id, 
                          :approved_flag => true,
                          :approved_by => row.approved_by)
        end
      end
    else
      @roles.each do |row|
        @role = params["approved_flag_" + row.id.to_s()]
        if(@role != nil)
          Role.delete(row.id)
        end
      end
    end

    render 'index'
  end
end
