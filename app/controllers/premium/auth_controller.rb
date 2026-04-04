class Premium::AuthController < ApplicationController
  def show; end

  def create
    email = params[:email].downcase.strip
    user = User.find_by(email: email, premium: true)

    if user
      AuthMailer.auth_code(user, user.auth_code).deliver_now
      session[:premium_email] = email
    end

    render turbo_stream: turbo_stream.replace(
      "login_frame",
      partial: "shared/premium_verification"
    )
  end

  def show
    redirect_to root_path
  end

  def destroy
    cookies.delete :access_token
    redirect_to root_path, notice: "Du wurdest ausgeloggt."
  end
end
