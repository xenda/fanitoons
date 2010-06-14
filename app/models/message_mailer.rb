class MessageMailer < ActionMailer::Base

  def email_copy(message)
    @recipients   = message.to.email
    @from         = message.from.email
    @subject      = "[Patatoon]" + message.subject
    @sent_on      = Time.now
    @content_type = "text/html"
    @body[:from_login] = message.from.name
    @body[:to_login] = message.to.name
    @body[:content] = message.content
  end


end
