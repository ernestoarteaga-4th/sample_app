class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end

  def create
  	if validateEmail4thSource(params[:session][:email])
		if authUserInPopEmailServer(params[:session][:email], params[:session][:password])
			user = User.find_by_email(params[:session][:email])	
		end
	else
		user = User.authenticate(params[:session][:email],params[:session][:password]) 
	end    
    	if user.nil?
      		flash.now[:error] = "Invalid email/password combination."
     	 	@title = "Sign in"
      		render :new
    	else
      		sign_in user
      		redirect_back_or root_path
    	end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
