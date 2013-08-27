class FollowingsController < ApplicationController
  before_filter :authenticate

  def follow
      #params[:id] = :followed_id
      #params[:following] = true
      #params[:following][:followed_id]
      @candidate = Candidate.find(params[:id] )
      @follow = current_candidate.followings.build(:followed_id => @candidate.id)
      #binding.pry
      if @follow.save
        logger.info "following saved"
        redirect_to @candidate
      else
        logger.info "following Error"
        flash[:success] = "Error"
        redirect_to @candidate
      end
  end
  
  def destroy
     @candidate = Candidate.find(params[:id])
    current_candidate.followings.find_by_followed_id(@candidate.id).destroy
    redirect_to @candidate
  end  
end
