class PagesController < ApplicationController
  include Visitables
  def index
    @offers = Offer.cached_offers
    @blog_posts = BlogPost.cached_blogs
    @bundeslands =Bundesland.cached_bundeslands
    @new_partner ||= User.where(online: true).last
    get_besucheranzahl
  end

  def werbung; end
  def impressum; end
  def datenschutz; end
end
