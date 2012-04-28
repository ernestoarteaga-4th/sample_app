class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :index]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => [:destroy]

  def index
    @users = User.paginate(:page => params[:page])
    @title = "All users"
  end

  def show
    @user  = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
  end
  
  def new
    @user  = User.new
    @error = @user.errors
    @title = "Sign up"
  end

  def edit
   @title  = "Edit user"
   @error  = current_user.errors
  end 

  def create
    @user = User.new(params[:user])
    @error = @user.errors
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = "Sign up"
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    @error = @user.errors
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render :edit
    end
  end
 
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  private

    def admin_user
      redirect_to(root_path) unless current_user.admin? 
    end

#    def authenticate
#      deny_access unless signed_in?
#    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
