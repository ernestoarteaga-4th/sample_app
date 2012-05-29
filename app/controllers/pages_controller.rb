class PagesController < ApplicationController
  def home
    @title = "Home"
    @micropost = Micropost.new if signed_in?
    @error = current_user.errors if signed_in?
    @page_results = current_user.feed.paginate(:page => params[:page]) if signed_in?
    @user = current_user
    if @page_results != nil
      flash.now[:success] =  "About #{@page_results.count} results."
    end
  end

  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About"
  end
  
  def search
    if params[:q]
      query = params[:q]
      @title = "Home"
      @user = current_user
      @micropost = Micropost.new if signed_in?
      @error = current_user.errors if signed_in?
      @feed_items = Micropost.search_from_users_followed_by(current_user, query)
      paginate(@feed_items, 5)
      flash.now[:success] = "About #{@feed_items.count} results."
      render 'home'
    end
  end
end
