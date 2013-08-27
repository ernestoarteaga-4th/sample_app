class StaffCandidatesController < ApplicationController
  def index
=begin
    @candidates = Candidate.paginate(:page => params[:page], 
                                     :conditions => ["admin_flag IS NOT TRUE"],
                                   :per_page => 20)
=end
      user_level = get_user_level

	 admin_users = AdminUsers.all
	 higher_level_users = []
	 @candidates = Candidate.paginate(:page => params[:page], :per_page => 20).each do |candidate|
	   higher_level_users << candidate if !is_lower_level(candidate, admin_users, user_level)
	 end
	 
	 higher_level_users.each do |candidate|
	   @candidates.delete(candidate)
	 end
	 
	 @candidates.each do |candidate|
	   @candidates.delete(candidate) if candidate.id == current_candidate.id
	 end
	 								   
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
  
  private
   
   def is_lower_level(candidate, admins, user_level)
     is_lower_lvl = true
	 admins.each do |admin|
	    is_lower_lvl = false if admin.candidates_id == candidate.id && admin.lvl > user_level
	 end
	 
	 is_lower_lvl
   end
   
   def get_user_level
   	user_level_maps = {'Admin' => 0, 'Super Admin' => 1}
	user_level_maps[get_user_type]
   end
  
end