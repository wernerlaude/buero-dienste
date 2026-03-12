class PagesController < ApplicationController
  include Visitables
  before_action :track_daily_visit
  def index
    @offers = Offer.cached_offers
    @blog_posts = BlogPost.cached_blogs
    @latest_blog_post ||= BlogPost.pluck(:id).last
    @bundeslands =Bundesland.cached_bundeslands
    @new_partner ||= User.where(online: true).last
    @tags = Tag.cached_tags
    get_besucheranzahl
  end

  def tab
    case params[:tab]
    when "bundesland"
      @bundeslands = Bundesland.cached_bundeslands
      render partial: "pages/bundesland", locals: { bundeslands: @bundeslands }, layout: false
    when "plz"
      render partial: "pages/plz_suche", layout: false
    end
  end

  def werbung; end
  def impressum; end
  def datenschutz; end



  private

  def track_daily_visit
    Rails.cache.fetch("visits_#{Date.current}", expires_in: 25.hours) { 0 }
    key = "visits_#{Date.current}"
    Rails.cache.increment(key)
  end
end
