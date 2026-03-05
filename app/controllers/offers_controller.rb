class OffersController < ApplicationController
  def show
    @offer = Offer.find_by(slug: params[:id])
    @users = grouped_offers(@offer)
    @count_offers = @offer.users.size
  end

  private
  def grouped_offers(offer)
    Rails.cache.fetch([ "users_offers", offer.id ], expires_in: 12.hours) do
      users = offer.users.includes(:header_image_attachment)
      {
        premium: users.premium.plz.online,
        standard: users.standard.plz.online
      }
    end
  end
end
