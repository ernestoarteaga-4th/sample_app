class InterviewersController < ApplicationController
  def index
    @interviewers = Interviewer.all
  end

  def create
    @interviewer = Interviewer.new(params[:i])

    @interviewer.updated_by = current_candidate.first_name + " " + 
                              current_candidate.middle_name + " " + 
                              current_candidate.first_last_name + " " + 
                              current_candidate.second_last_name
    @interviewer.save

    redirect_to File.join('/staff/', current_candidate.id.to_s(), '/interviewers')
  end

  def destroy
    Interviewer.delete(params[:id])

    redirect_to File.join('/staff/', current_candidate.id.to_s(), '/interviewers')
  end
end