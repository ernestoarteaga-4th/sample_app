class FollowingsController < ApplicationController
  before_filter :authenticate

  def create
      @user = User.find(params[:following][:followed_id])
      @follow = current_user.followings.build(:followed_id => @user.id)
      if @follow.save
        redirect_to @user
      else
        flash[:success] = "Error"
        redirect_to @user
      end
  end
  
  def destroy
     @user = User.find(params[:following][:followed_id])
    current_user.followings.find_by_followed_id(@user.id).destroy
    redirect_to @user
  end  
end
