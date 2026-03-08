class OffersController < ApplicationController
  def show
    @offer = Offer.find_by(slug: params[:id])
    @users = grouped_offers(@offer)
    @count_offers = @offer.users.size
  end

  private
  def grouped_offers(offer)
    Rails.cache.fetch(["users_offers", offer.id], expires_in: 12.hours) do
      users = offer.users.with_attached_header_image
      {
        premium: users.premium.plz.online.to_a,
        standard: users.standard.plz.online.to_a
      }
    end
  end
end
