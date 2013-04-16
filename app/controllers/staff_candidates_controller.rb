class StaffCandidatesController < ApplicationController
  def index
    @candidate = Candidate.where("admin_flag IS NOT TRUE")
    @title = "All Candidates"
    flash[:success] = "About #{@candidate.count} Results."
  end

  def search
    if params[:q]
      query = params[:q]
      @users = User.find_with_ferret(query + "*", :limit => :all)
      @users = @users.sort_by{ |user| user.name}
      paginate(@users, 10)
      flash[:success] = "About #{@users.count} Results."
      render 'index'
    end
  end
end