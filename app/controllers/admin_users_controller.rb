class AdminUsersController < ApplicationController
	def index
    @candidates = AdminUsers.paginate(:page => params[:page], 
                                     #:conditions => [""],
                                     :per_page => 20)
	end

	def edit
	    if !params.blank?
	      @user = AdminUsers.find(params[:id])
	      @active = @user.is_active
	      @user.is_active = !@active	      
	      if @user.save
	        flash[:success] = "Profile updated."
	      end	     
	    end		
	    @candidates = AdminUsers.paginate(:page => params[:page], 
	                                     #:conditions => [""],
	                                     :per_page => 20)	    
	    render :update, :layout => false
	end
end
