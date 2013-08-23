
class CandidatesController < ApplicationController
  #before_filter :authenticate, :except => [:show, :new, :create, :change]
  #before_filter :correct_user, :only => [:edit, :update]
  skip_filter :verify_signed_in, :only => [:new, :create]
  before_filter :admin_user,   :only => [:destroy]

  def index
    @candidate = Candidate.all
    @title = "All users"
    paginate(@candidate, 10)
    flash[:success] = "About #{@candidate.count} results."
  end

  def show
    @candidate  = Candidate.find(params[:id])
    #@microposts = @candidate.microposts.paginate(:page => params[:page])
    @title = @candidate.name
  end

  def new
    @candidate  = Candidate.new
    @error = @candidate.errors
    @title = "Sign up"
  end

  def edit
    id = params[:id] unless params.blank?
    #if !current_candidate.admin_flag.nil?
	if @@admin_roles.include?( get_user_type )
      @candidate = Candidate.find(id)
      @error = @candidate.errors
    else
      @candidate = Candidate.find(current_candidate.id)
      @error  = current_candidate.errors
    end
   @title  = "Edit user"
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
=begin
    #If no current_candidate, there's no login so act as new candidate.
    if !current_candidate.nil?
      if !current_candidate.admin_flag.nil?
        #algo
        @candidate = Candidate.new(params[:candidate])
        @error = @candidate.errors
        if @candidate.save  
            #Se guardo, redireccionar al edit http://localhost:3000/candidates/6/admin
            redirect_to "/candidates/#{@candidate.id}/admin"
        end
      end
    else
=end
      @candidate = Candidate.new(params[:candidate])
      @error = @candidate.errors
      if verify_recaptcha() == false
        @candidate.errors[:recaptcha] = "is invalid"
        @title = "Sign up"
        render :new
      else
        if @candidate.save  
		  set_user_type(@candidate)
          sign_in @candidate
          #UserMailer.welcome_email(@user).deliver
          flash[:success] = "Welcome to the Sample App!"
          redirect_to root_path
        else
          @title = "Sign up"
          render :new
        end
      end
    #end
	
  end

  def update
    #binding.pry
    @candidate = Candidate.find(params[:id])
    @error = @candidate.errors
    if @candidate.update_attributes(params[:candidate])
      flash[:success] = "Profile updated."
      #redirect_to root_path
      render :edit
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

  def newcandidate
     @candidate = Candidate.new
     render '/candidates/newcandidate_admin'
  end  

  private
    def param_posted?(sym)
      request.post? and params[sym]
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def correct_user
      @candidate = Candidate.find(params[:id])
      redirect_to(root_path) unless current_candidate?(@candidate)
    end
end
