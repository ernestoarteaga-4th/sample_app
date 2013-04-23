class ReportController < ApplicationController
  def index
    @technologies = Tag.where("type_tag = 3")
    @interview_types = InterviewsType.all
  end

  def search

    #@msg = { "success" => "true", "message" => "hello", "state" => params[:state]}
 
    #respond_to do |format|
      #format.html
      #format.json { render json: @msg }
    #end


    formt = params["search"]["points"]
rrrrr = params["interview_text"]

    flash[:notice] = rrrrr
  end
end