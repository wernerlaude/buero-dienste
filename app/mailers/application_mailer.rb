class ApplicationMailer < ActionMailer::Base
  default from: "support@buero-dienstleistungen.com"
  # default from: "support@my-online-check.de"
  layout "mailer"
end
