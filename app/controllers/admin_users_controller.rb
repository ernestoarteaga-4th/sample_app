class AdminUsersController < ApplicationController
	def index
    @candidates = AdminUsers.paginate(:page => params[:page], 
                                     #:conditions => [""],
                                     :per_page => 20)
	end

	def edit
	    if !params.blank?
	      @user = AdminUsers.find(params[:id])
        if params[:role].to_i > 0
          @user.is_active = true
        else
          @user.is_active = false
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
