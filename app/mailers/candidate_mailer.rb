class CandidateMailer < ActionMailer::Base
  default from: "jesus.parra@4thsource.com"

  def reminder(candidate)
    #@subject = 'Your login information at tweet.4thsource.com'
    #@body["candidate"] = candidate
    #logger.info "candidate name #{candidate.first_name}"
    @candidate_name = candidate.first_name
    @candidate_pass = candidate.password
    @recipients = candidate.email
    @from = 'Admin <jesus.parra@4thsource.com>'
    mail(to: @recipients, subject: 'Your login information at tweet.4thsource.com')
  end
  
end
