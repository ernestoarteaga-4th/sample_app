class CandidateTrainingController < ApplicationController
  before_filter :authenticate
  
   def index
    @candidate = current_candidate
    @error = @candidate.errors
    
    @total_trainings = @candidate.candidate_trainings
    @training = CandidateTraining.new

  end
 
  def new
    @candidate = current_candidate
    @candidate_training = @candidate.candidate_trainings.build(params[:candidate_training])
    
      if @candidate_training.save
        flash[:success] = "trainings was saved successfully."
      else
        training.destroy
        flash[:notice] = "An error occurred while the system save the trainings#{@candidate_training.errors.as_json}"
      end
    redirect_to request.referer 
  end
  
  def destroy
    CandidateTraining.find(params[:id]).destroy
    redirect_to request.referer
  end
end
