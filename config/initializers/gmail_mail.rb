require "openssl"
require "net/smtp"

ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
	:address => "smtp.gmail.com",
	:port => 587,
	:authentication => :plain,
   :enable_starttls_auto => true,
	:domain => "patatoon.com",
	:user_name => "contacto@patatoon.com",
	:password => "patatoon.2010",
}
