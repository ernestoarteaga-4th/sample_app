class MicropostsController < ApplicationController 
  before_filter :authenticate,    :only => [:create, :destroy]
  before_filter :authorized_candidate, :only => :destroy

  def create
    content = params[:message_text]
    candidate_id = params[:candidate_id]
    created_by = current_candidate.id
    @candidate = Candidate.find(candidate_id)
    @micropost = @candidate.microposts.build(:content => content, :candidate_id => candidate_id, :created_by => created_by)
    @error = @micropost.errors
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_back_or root_path
  end 

  private
    def authorized_candidate
      @micropost = Micropost.find(params[:id])
      redirect_to root_path unless current_user?(@micropost.user)
    end
end
