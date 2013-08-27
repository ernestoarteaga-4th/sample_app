module SessionsHelper
  USER = 0
  ADMIN = 1
  SUPERADMIN = 2

  require 'net/pop'

  def isSuperAdmin
    deny_access unless role == SessionsHelper::SUPERADMIN
  end

  def authenticate
    deny_access unless signed_in?
  end

  def current_candidate?(candidate)
    candidate == current_candidate
  end

  def deny_access
    store_location
    flash[:notice] = "Please sign in to access this page."
    redirect_to signin_path
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def sign_in(candidate)
    cookies.permanent.signed[:remember_token] = [candidate.id, candidate.salt]
    current_candidate = candidate
    logger.debug "\033[0;31mCANDIDATE ID: #{current_candidate.id}\033[0;37m"
  end

  def followed_in? (candidate)
    current_candidate != candidate
  end

  def is_follow? (candidate)
    @follow = current_candidate.followings.find_by_followed_id(candidate)
    !@follow.nil?
  end

  def current_candidate
    @current_candidate ||= candidate_from_remember_token
  end

  def signed_in?
    !current_candidate.nil?
  end

  def sign_out
    cookies.delete(:remember_token)
    current_candidate = nil
  end

  private
    def candidate_from_remember_token
      Candidate.authenticate_with_salt(*remember_token)
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end

    def store_location
      session[:return_to] = request.fullpath
    end

    def clear_return_to
      session[:return_to] = nil
    end

    def authCandidateInPopEmailServer(email, password)
      begin
        Net::POP3.auth_only('pop.4thsource.com', 110, email, password)
        return true
      rescue Net::POPAuthenticationError
        return false
      end
    end

    def role
      if !current_candidate.nil?
        if !current_candidate.admin_users.is_active?
          0
        elsif current_candidate.admin_users.is_active? and !current_candidate.admin_users.lvl?
          1
        elsif current_candidate.admin_users.is_active? and current_candidate.admin_users.lvl?
          2
        end
      else
        -1
      end
    end

    def validateEmail4thSource(email)
      email_regex = %r{
	       ^
         [0-9a-z]+
         [\.]
         [0-9a-z]+
         @
         4thsource
         [\.]
         com
		     $
      }xi
	    return true if email =~ email_regex
      return false
    end
end
