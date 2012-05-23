class ApplicationController < ActionController::Base
  protect_from_forgery
  
  include SessionsHelper

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

