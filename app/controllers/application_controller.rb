class ApplicationController < ActionController::Base
  protect_from_forgery
  
  include SessionsHelper
  helper :date
  helper_method :set_user_type, :get_user_type
  before_filter :verify_signed_in

  def verify_signed_in
    unless signed_in?
      redirect_to '/signin' if request.path != '/'
    end
  end
  
  @@admin_roles = ['Admin', 'Super Admin']
  
  def set_user_type(user)
  
    admin_user = AdminUsers.find_by_candidates_id(user.id)
	roles = {'0' => 'Admin', '1' => 'Super Admin'}
	
	if admin_user
	  session[:user_type] = roles[admin_user.lvl.to_s] 
	else
	   session[:user_type] = 'Candidate'
	end
	
  end
  
  def get_user_type
    session[:user_type]
  end

  def paginate(results, per_page)
    if(params[:page].to_i>0)
      current_page = params[:page].to_i
    else
      current_page = 1
    end    
    @page_results = WillPaginate::Collection.create(current_page, per_page, results.count) do |pager|
      start = (current_page-1)*per_page # assuming current_page is 1 based.
      pager.replace(results.to_a[start, per_page])
    end
  end
  
end

