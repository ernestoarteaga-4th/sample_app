class FollowingsController < ApplicationController
  before_filter :authenticate

  def create
      @user = User.find(params[:following][:follow_user]) 
      @follow = current_user.followings.build(:follow_user => @user.id)
      if @follow.save
        redirect_to @user
      else
        flash[:success] = "Error"
        redirect_to @user
      end
  end
  
  def destroy
     @user = User.find(params[:following][:follow_user]) 
    current_user.followings.find_by_follow_user(@user.id).destroy
    redirect_to @user
  end  
end
