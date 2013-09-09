class MicropostsController < ApplicationController 
  before_filter :authenticate,    :only => [:create, :reply, :update, :feed_micropost, :destroy]
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
      MicropostsMailer.micropost(@micropost, @candidate, current_candidate).deliver
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
    @micropost = @candidate.microposts.build(:content => content, :candidate_id => created_by, :created_by => candidate_id, :is_active => 1, :checked => 0)
    @error = @micropost.errors
    if @micropost.save
      #@micropost2 = @candidate.microposts.build(:content => content, :candidate_id => created_by, :created_by => candidate_id, :is_active => 1, :checked => 0)
      #@error2 = @micropost.errors
      #if @micropost2.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
      #else
       # @feed_items = []
        #render 'pages/home'
      #end
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

  def feed_micropost
    id_current_candidate = current_candidate.id

    respond_to do |format|
      format.html
      if params[:solomicro] == "0"
        format.json { render :json =>  @page_results = Micropost.find(:all, :select =>"microposts.id, microposts.content, microposts.candidate_id, microposts.created_at, microposts.updated_at, microposts.created_by, microposts.checked, microposts.is_active, candidates.id, candidates.first_name, candidates.first_last_name", :joins => "JOIN candidates ON candidates.id = microposts.created_by", :conditions => ["microposts.is_active = 1 AND (microposts.candidate_id = ? OR microposts.created_by = ?)", params[:id], params[:id]])}
      else
        format.json { render :json =>  @page_results = Micropost.find(:all, :select =>"microposts.id, microposts.content, microposts.candidate_id, microposts.created_at, microposts.updated_at, microposts.created_by, microposts.checked, microposts.is_active, candidates.id, candidates.first_name, candidates.first_last_name", :joins => "JOIN candidates ON candidates.id = microposts.created_by", :conditions => ["microposts.created_by != microposts.candidate_id AND microposts.candidate_id NOT IN (SELECT microposts.candidate_id FROM microposts WHERE microposts.candidate_id NOT IN(:follower_id, :user_being_followed)) AND microposts.created_by NOT IN (SELECT microposts.created_by FROM microposts WHERE microposts.created_by NOT IN(:follower_id, :user_being_followed)) AND microposts.is_active = 1",{:follower_id => id_current_candidate.to_i, :user_being_followed => params[:user_followed].to_i}])}
      end      
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
