class EmailController < ApplicationController
  def remind
    if param_posted?(:user)
      email = params[:user][:email]
      user  = User.find_by_email(email)
      if user
        user.password = user.password_confirmation = user.change_password_flag = new_hash(25)
        user.save!
        UserMailer.deliver_reminder(user)
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
