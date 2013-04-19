class FollowingsController < ApplicationController
  before_filter :authenticate

  def follow
      @candidate = Candidate.find(params[:following][:followed_id])
      @follow = current_candidate.followings.build(:followed_id => @candidate.id)
      if @follow.save
        redirect_to @candidate
      else
        flash[:success] = "Error"
        redirect_to @candidate
      end
  end
  
  def destroy
     @candidate = Candidate.find(params[:following][:followed_id])
    current_candidate.followings.find_by_followed_id(@candidate.id).destroy
    redirect_to @candidate
  end  
end
