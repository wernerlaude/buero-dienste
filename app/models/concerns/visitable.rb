module Visitable
  extend ActiveSupport::Concern

  def current_user
    @current_user ||= lookup_user_by_cookie
  end

  def logged_in?
    !!current_user
  end

  def auth_code
    totp.now
  end

  def valid_auth_code?(code)
    totp.verify(code, drift_behind: 300).present?
  end

  def valid_visitor_code?(code)
    totp.verify(code, drift_behind: 300).present?
  end

  private
  def generate_otp_secret
    self.otp_secret = ROTP::Base32.random(16)
  end

  def totp
    ROTP::TOTP.new(otp_secret, issuer: "office")
  end

  def lookup_user_by_cookie
    return unless cookies.permanent.encrypted[:access_token]

    User.joins(:access_tokens).find_by(
      access_tokens: {
        token: cookies.permanent.encrypted[:access_token]
      }
    )
  end
end
