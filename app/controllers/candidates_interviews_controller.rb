class CandidatesInterviewsController < ApplicationController
  
  def index
    @candidate  = Candidate.find_by_id(params[:id])
    #@microposts = @candidate.microposts.paginate(:page => params[:page])
    @title = ' '

    @candidates_interviews_items = CandidatesInterview.where('candidate_id=?', @candidate.id)
    
  end
  
  def new
    @candidate  = Candidate.find(params[:id])
    
    if request.post?
      @cand_inter = @candidate.candidates_interviews.build(params[:cand_inter])
      if @cand_inter.save
        flash[:success] = "Project was saved successfully."
        render :index
      else
        flash[:notice] = "An error occurred while the system save the project."
      end
    else
      @cand_inter  = CandidatesInterview.new
      @error = @cand_inter.errors
    end
  end
  
  def edit
    @candidate = current_candidate
    
    if request.post?
      @candidate = Candidate.find(params[:id])
      @cand_inter = @candidate.candidates_interviews.find(params[:cand_inter_id])
      @cand_inter.update_attributes(params[:cand_inter])
      if @cand_inter.save
        flash[:success] = "Interview was saved successfully."
        render 'index'
      else
        flash[:notice] = "An error occurred while the system save the project."
      end
    else
      @candidate = Candidate.find(params[:id])
      @cand_inter = @candidate.candidates_interviews.find(params[:cand_inter_id])
    end
  end
  
  def delete
    @candidate = Candidate.find(params[:id])
    CandidatesInterview.find(params[:cand_inter_id]).destroy
    render 'index'
  end
end
