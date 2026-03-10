class NoticeMailer < ApplicationMailer
  def notice_email
    @user = params[:user]
    mail(to: "mail@laude.dev", subject: "Anfrage!!")
  end

  def welcome_email
    @user = params[:user]
    @url = "https://www.buero-dienstleistungen.com"
    mail(to: @user.email, subject: "Willommen bei buero-dienstleistungen.com")
  end

end
