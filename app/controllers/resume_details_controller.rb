class ResumeDetailsController < ApplicationController 
  before_filter :authenticate

  def destroy
    ResumeDetail.find(params[:id]).destroy
    redirect_to request.referer
  end 
end
