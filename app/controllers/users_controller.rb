class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create, :change]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => [:destroy]

  def index
    @users = User.all
    @title = "All users"
    paginate(@users, 10)
    flash[:success] = "About #{@users.count} results."
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
  
  def change
   if param_posted?(:user)
     @user = User.find(params[:id])
     @user.change_password_flag = nil
     if @user.update_attributes(params[:user])
       flash[:success] = "Profile updated."
       redirect_to :signin
     else
       render :change
     end
    else
      @user = User.find(params[:id])
      if @user && @user.change_password_flag == params[:code]
        @error = @user.errors
        render :change
      else
        flash[:notice] = "Invalid code!"
        redirect_to root_path
      end
    end
  end

  def create
    @user = User.new(params[:user])
    @error = @user.errors
    if @user.save
      sign_in @user
      UserMailer.welcome_email(@user).deliver
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
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    users_id = @user.followings.map(&:followed_id).join(", ")
    @users = User.where("id IN (#{users_id})").paginate(:page => params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    users_id = @user.followers.map(&:id).join(", ")
    @users = User.where("id IN (#{users_id})").paginate(:page => params[:page])
    render 'show_follow'
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
  
  private
    def param_posted?(sym)
      request.post? and params[sym]
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin? 
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
