class ReportController < ApplicationController
  def index
    @candidates = Candidate.paginate(:page => params[:page], 
                                     :conditions => ["admin_flag IS NOT TRUE"],
                                     :per_page => 20)
  end

  def search
    @msg = { "success" => "true", "message" => "hello", "state" => params[:state]}
 
    respond_to do |format|
      format.html
      format.json { render json: @msg }
    end
  end
end