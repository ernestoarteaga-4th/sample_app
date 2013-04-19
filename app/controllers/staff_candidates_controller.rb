class StaffCandidatesController < ApplicationController
  def index
    @candidates = Candidate.paginate(:page => params[:page], 
                                     :conditions => ["admin_flag IS NOT TRUE"],
                                     :per_page => 10)
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