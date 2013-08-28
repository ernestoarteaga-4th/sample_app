class AdminUsersController < ApplicationController
before_filter :isSuperAdmin

  def index
    @candidates = Candidate.joins(:admin_users).paginate(:page => params[:page], 
                                     #:conditions => [""],
                                     :per_page => 20,
                                     :order => 'first_last_name')
  end

  def new
    unless params[:letra].nil?
      @candidates = Candidate.includes(:admin_users).where('first_last_name LIKE ?', params[:letra] + '%').order('first_last_name')
    else
      @candidates = Candidate.includes(:admin_users).where('first_last_name LIKE "a%"').order('first_last_name')
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
    begin
      @user = AdminUsers.where('candidates_id = ?', params[:id].to_i).first()
      if @user == nil
        render text: "User not found " + params[:id]
      else
        case params[:role].to_i
        when 0 then
          @user.lvl = 0
          @user.is_active = 0
        when 1
          @user.lvl = 0
          @user.is_active = 1
        when 2
          @user.lvl = 1
          @user.is_active = 1
        end          
        if @user.save
          @candidates = Candidate.joins(:admin_users).paginate(:page => params[:page], 
                                           #:conditions => [""],
                                           :per_page => 20).order('first_last_name')
          render :update, :layout => false
        else
          render text: @user.errors.full_messages
        end
      end
    rescue Exception => e  
      render text: "User not found " + params[:id] + ", " + e.message + ", " + e.backtrace.inspect
    end
  end

  def search    
    @candidates = Candidate.includes(:admin_users).where('first_name LIKE ? OR first_last_name LIKE ? OR email LIKE ?', params[:txt] + '%',params[:txt] + '%',params[:txt] + '%').order('first_last_name')
    render :newajax, :layout => false
  end

end
