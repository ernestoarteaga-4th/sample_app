class SessionsController < ApplicationController
  
  skip_filter :verify_signed_in, :only => [:new, :create, :destroy]
  
  def new
    @title = "Sign in"
  end

  def create
  
    @flag = false
    if validateEmail4thSource(params[:session][:email])
      if authCandidateInPopEmailServer(params[:session][:email], params[:session][:password])
        candidate = Candidate.find_by_email(params[:session][:email])    
        @flag = true
      end
    else
      candidate = Candidate.authenticate(params[:session][:email],params[:session][:password])
    end
	
    if candidate.nil?
      if @flag
        flash.now[:error] = "You do not have a profile. Please, go to Register now!."
      else
        flash.now[:error] = "Invalid email/password combination."
      end
      @title = "Sign in"
      render :new
    else
	  set_user_type(candidate)
      sign_in candidate
	  
      redirect_back_or root_path
	  
    end
	
  end


=begin
  def create
    @flag = false
    candidate = Candidate.authenticate(params[:session][:email],params[:session][:password])
    if candidate.nil?
      if @flag
        flash.now[:error] = "You do not have a profile. Please, go to Register now!."
      else
        flash.now[:error] = "Invalid email/password combination."
      end
      @title = "Sign in"
      render :new
    else
      sign_in candidate
      redirect_back_or root_path
    end
  end
=end

  def destroy
    sign_out
    redirect_to root_path
  end
  
end
