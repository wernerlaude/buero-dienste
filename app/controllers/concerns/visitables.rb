module Visitables
  extend ActiveSupport::Concern

  def get_besucheranzahl
    # @user_days = ((Date.parse "2024-06-30")...Date.today).count
    homepage_days = ((Date.parse "2025-08-05")...Date.today).count
    @visits_all ||= User.online.pluck(:count).sum
    @visits_min ||= User.minimum(:count)
    @visits_max ||= User.maximum(:count)
    @visits_schnitt ||= homepage_days > 0 ? (@visits_all.to_f / homepage_days).round(2) : 0
    @visits_heute ||= Rails.cache.read("visits_#{Date.current}") || 0
  end

  def get_blogs_read
    @blogs_all ||= BlogPost.online.pluck(:count).sum
  end

  def mark_latest
    @latest_blog_post ||= BlogPost.pluck(:id).last
  end




end
