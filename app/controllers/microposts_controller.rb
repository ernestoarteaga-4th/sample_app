class MicropostsController < ApplicationController 
  before_filter :authenticate,    :only => [:create, :reply, :update, :destroy]
  before_filter :authorized_candidate, :only => :destroy

  def create
    content = params[:message_text]
    candidate_id = params[:candidate_id]
    created_by = current_candidate.id
    @candidate = Candidate.find(candidate_id)
    @micropost = @candidate.microposts.build(:content => content, :candidate_id => candidate_id, :created_by => created_by, :is_active => 1, :checked => 0)
    @error = @micropost.errors
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  def reply
    content = params[:reply_text]
    candidate_id = current_candidate.id
    created_by = params[:can_id]
    @candidate = Candidate.find(created_by)
    @micropost = current_candidate.microposts.build(:content => content, :candidate_id => candidate_id, :created_by => candidate_id, :is_active => 1, :checked => 0)
    @error = @micropost.errors
    if @micropost.save
      @micropost2 = @candidate.microposts.build(:content => content, :candidate_id => created_by, :created_by => candidate_id, :is_active => 1, :checked => 0)
      @error2 = @micropost.errors
      if @micropost2.save
        flash[:success] = "Micropost created!"
        redirect_to root_path
      else
        @feed_items = []
        render 'pages/home'
      end
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  def update
    @micropost = Micropost.find(params[:id])
    if @micropost.update_attributes(:is_active => '0')
      flash[:success] = "Micropost removed"
      redirect_back_or root_path
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
