class PagesController < ApplicationController

  include Visitables
  def index
    @offers = Offer.cached_offers
    @blog_posts = BlogPost.cached_blogs
    @bundeslands =Bundesland.cached_bundeslands
    @new_user ||= User.where(online: true).last
    get_besucheranzahl
  end

  def faq; end

  def werbung; end
  def about; end
  def impressum; end
  def datenschutz; end
end
