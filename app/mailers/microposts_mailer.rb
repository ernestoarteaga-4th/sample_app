class MicropostsMailer < ActionMailer::Base
  default :from => "jesus.parra@4thsource.com"

  def micropost(micropost, candidate, created_by)
    @subject = 'New micropost at 4th source jobs'
    @candidate = candidate
    @recipients = candidate.email
    @from = 'Admin <jesus.parra@4thsource.com>'
    @micropost = micropost
    @created_by = created_by
    mail(:to => @recipients, :subject => @subject)
  end
end
