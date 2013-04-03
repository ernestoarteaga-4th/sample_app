class ResumeDetailsController < ApplicationController 
  before_filter :authenticate

  def destro
    ResumeDetail.find(params[:id]).destroy
    redirect_to request.referer
  end 
end
