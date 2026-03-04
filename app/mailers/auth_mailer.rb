class AuthMailer < ApplicationMailer
  def auth_code(user, auth_code)
    @user = user
    @auth_code = auth_code

    mail(to: @user.email, subject: "#{@auth_code} ist Ihr Verification Code")
  end

  def visitor_code(visitor, auth_code)
    @visitor = visitor
    @auth_code = auth_code

    mail(to: @visitor.email, subject: "#{@auth_code} ist Ihr Verification Code")
  end
end
