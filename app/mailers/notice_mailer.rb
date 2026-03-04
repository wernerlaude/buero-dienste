class NoticeMailer < ApplicationMailer
  default from: "support@buero-dienstleistungen.com"

  def notice_email
    @user = params[:user]
    mail(to: "mail@laude.dev", subject: "Anfrage!!")
  end

  def comment_email
    @user = params[:user]
    mail(to: "support@buero-dienstleistungen.com", subject: "Neuer Besucher!")
  end

  def markt_email
    @user = params[:user]
    mail(to: "support@buero-dienstleistungen.com", subject: "Neuer Markteintrag!")
  end

  def welcome_email
    @user = params[:user]
    @url = "https://www.buero-dienstleistungen.com"
    mail(to: @user.email, subject: "Willommen bei buero-dienstleistungen.com")
  end

  def anfrage_email
    @contact = params[:contact]
    @url = "https://www.buero-dienstleistungen.com"
    mail(to: @contact.user_email, subject: "Kundenanfrage")
  end
end
