class IdiomsController < ApplicationController
  
  def index
    @user = current_user
    @error = @user.errors
    
    if @user.resume.nil?
      @user.build_resume.save
    end
    @total_idioms = @user.resume.idioms
  end
  
  def new
    @user = current_user
    @idiom = @user.resume.idioms.new(params[:idiom])
    @error = @idiom.errors
    
    if @idiom.save
      flash[:success] = "Idiom was saved successfully."
    else
      flash[:notice] = "An error occurred while the system save the idiom."
    end
    
    redirect_to request.referer
  end
  
  def destroy
    Idiom.find(params[:id]).destroy
    redirect_to request.referer
  end
end
