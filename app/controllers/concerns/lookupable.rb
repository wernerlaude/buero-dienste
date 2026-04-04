module Lookupable
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user
    helper_method :current_user, :logged_in?  # <- sicherstellen
  end

  def current_user
    @current_user
  end

  def logged_in?
    !!current_user
  end

  def require_login
    unless logged_in?
      redirect_to root_path, notice: "Bitte zuerst einloggen."
    end
  end

  private

  def set_current_user
    @current_user = lookup_user_by_cookie
  end

  def lookup_user_by_cookie
    token = cookies.encrypted[:access_token]
    return unless token

    access_token = AccessToken.active.find_by(token: token)
    return unless access_token

    access_token.user
  end
end
