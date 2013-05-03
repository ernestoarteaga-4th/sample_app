class InterviewersController < ApplicationController

  def index
    @candidate = current_candidate
  end
  
  def new
    if request.post?
      @interviewer = Interviewer.new(params[:interviewer])
      if @interviewer.save
        flash[:success] = "Interviewer was saved successfully."
        #render 'index'
        redirect_to File.join('/staff/', current_candidate.id.to_s, '/interviewers')
      else
        if @interviewer.id.to_s.empty?
          flash[:notice] = "The interviewer can not be null."
        else
          flash[:notice] = "An error occurred while the system save the interviewer."
        end
      end
    else
      @interviewer  = Interviewer.new
      @error = @interviewer.errors
    end    
  end

  def edit
    if request.post?
      @interviewer = Interviewer.find(params[:interviewer_id])
      @interviewer.update_attributes(params[:interviewer])
      if @interviewer.save
        flash[:success] = "Interviewer was saved successfully."
        render 'index'
      else
        flash[:notice] = "An error occurred while the system save the interviewer."
      end
    else
      @interviewer  = Interviewer.find(params[:interviewer_id])
      @error = @interviewer.errors
    end
  end
  
  def delete
    @candidateInterview = CandidatesInterview.where("interviewer_id = ?", params[:interviewer_id])
    if @candidateInterview.length > 0
      flash[:notice] = "This Interviewer is associated to an Interview, cannot be Deleted"
    else
      Interviewer.find(params[:interviewer_id]).destroy
    end
    render :index
  end
end