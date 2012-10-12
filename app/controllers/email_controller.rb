class EmailController < ApplicationController
  def remind
    if param_posted?(:candidate)
      email = params[:candidate][:email]
      candidate  = Candidate.find_by_email(email)
      if candidate
        candidate.password = candidate.password_confirmation = candidate.change_password_flag = new_hash(25)
        candidate.save!
        CandidateMailer.deliver_reminder(candidate)
        flash[:notice] = "Login information was sent successfully."
      end 
    end
  end
  
  private
    def param_posted?(sym)
      request.post? and params[sym]
    end
    
    def new_hash(len)
      chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
      hash = ""
      1.upto(len) { |i| hash << chars[rand(chars.size-1)] }
      return hash
    end

end
