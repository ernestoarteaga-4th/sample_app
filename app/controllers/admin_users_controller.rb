class AdminUsersController < ApplicationController
  
	def index
    @candidates = AdminUsers.joins(:candidate).paginate(:page => params[:page], 
                                     #:conditions => [""],
                                     :per_page => 20).order('candidates.first_last_name')
	end

  def new
    unless params[:letra].nil?
      @candidates = Candidate.where('first_last_name LIKE ?', params[:letra] + '%').order('first_last_name')
    else
      @candidates = Candidate.where('first_last_name LIKE "a%"').order('first_last_name')
    end
  end

  def add
    unless params[:id].nil?
      @u = AdminUsers.where(:candidates_id => params[:id].to_i)
      if @u.nil? or @u.length == 0
        @AdminUser = AdminUsers.new()
        @AdminUser.candidates_id = params[:id]
        @AdminUser.is_active = 1
        @AdminUser.lvl = 0
        @AdminUser.save
        render text: "User added successfuly"
      else
        render text: "User already exists in admin catalog "
      end
    else
      render text:"Incorrect parameters"
    end
  end

	def edit
	    unless params[:role].nil?
	      @user = AdminUsers.find(params[:id])
        @user.lvl = params[:role].to_i
        @user.is_active = @user.lvl != 0
	      @user.save
	    end		
	    @candidates = AdminUsers.joins(:candidate).paginate(:page => params[:page], 
                                     #:conditions => [""],
                                     :per_page => 20).order('candidates.first_last_name')
	    render :update, :layout => false
	end

end
