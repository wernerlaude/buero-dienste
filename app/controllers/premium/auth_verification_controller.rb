class Premium::AuthVerificationController < ApplicationController
  def create
    user = User.find_by(email: session[:premium_email], premium: true)

    if user.present? && user.valid_auth_code?(params[:verification_code])
      access_token = user.access_tokens.create!
      cookies.permanent.encrypted[:access_token] = access_token.token
      session.delete(:premium_email)

      redirect_to premium_root_path, notice: "Willkommen!", allow_other_host: false
    else
      render turbo_stream: turbo_stream.replace(
        "login_frame",
        partial: "shared/premium_verification",
        locals: { error: "Code ungültig, bitte nochmal versuchen." }
      )
    end
  end
end
