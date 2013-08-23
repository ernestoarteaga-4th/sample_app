class AdminUsersController < ApplicationController
	def index
    @candidates = AdminUsers.paginate(:page => params[:page], 
                                     #:conditions => [""],
                                     :per_page => 20)
	end

	def edit
	    if !params.blank?
	      @user = AdminUsers.find(params[:id])
        @user.lvl = params[:role].to_i
        if @user.lvl == 0
          @user.is_active = false
        else
          @user.is_active = true
        end
	      if @user.save
	        flash[:success] = "Profile updated."
	      end	     
	    end		
	    @candidates = AdminUsers.paginate(:page => params[:page], 
	                                     #:conditions => [""],
	                                     :per_page => 20)	    
	    render :update, :layout => false
	end

  def search
    if params[:q]
      query = params[:q]
      @users = User.find_with_ferret(query + "*", :limit => :all)
      @users = @users.sort_by{ |user| user.name}
      paginate(@users, 10)
      flash[:success] = "About #{@users.count} results."
      render 'index'
    end
  end

end
