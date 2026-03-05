module Visitables
  extend ActiveSupport::Concern

  def current_user
    @current_user ||= lookup_user_by_cookie
  end

  def logged_in?
    !!current_user
  end

  def get_besucheranzahl
    @user_days = ((Date.parse "2024-06-30")...Date.today).count
    @homepage_days = ((Date.parse "2025-08-05")...Date.today).count
    @visits_all ||= User.online.pluck(:count).sum
    @visits_min ||= User.minimum(:count)
    @visits_max ||= User.maximum(:count)
  end

  private

  def lookup_user_by_cookie
    return unless cookies.permanent.encrypted[:access_token]

    User.joins(:access_tokens).find_by(
      access_tokens: {
        token: cookies.permanent.encrypted[:access_token]
      }
    )
  end
end
