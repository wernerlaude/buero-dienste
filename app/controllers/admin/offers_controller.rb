# app/controllers/admin/offers_controller.rb
class Admin::OffersController < AdminController
  before_action :set_offer, only: [ :show, :edit, :update, :destroy ]

  def index
    begin
      # Build base query
      @offers = Offer.includes(:users).ranking

      # Stats für Dashboard
      @stats = {
        total: Offer.count,
        total_views: Offer.sum(:count) || 0
      }
      @top_offers = Offer.online.order(count: :desc).limit(5)
      @user_stats = Offer.joins(:users).group("offers.ident").count("users.id").sort_by { |_, count| -count }
                         .first(5)

    rescue => e
      Rails.logger.error "Error loading offers: #{e.message}"
      @offers = Offer.none
      @stats = {
        total: 0, online: 0, offline: 0, standard: 0, digital: 0, total_views: 0
      }
      flash.now[:alert] = "Fehler beim Laden der Angebote."
    end
  end

  def show; end

  def new
    @offer = Offer.new
    # Set default values
    @offer.online = true
    @offer.position = (Offer.maximum(:position) || 0) + 1
    @offer.category = 1 # Default: Klassische Bürodienste
  end

  def create
    @offer = Offer.new(offer_params)

    if @offer.save
      redirect_to edit_admin_offer_path(@offer),
                  notice: "✅ Angebot '#{@offer.card_title}' erfolgreich erstellt."
    else
      flash.now[:alert] = "Fehler beim Erstellen: " + @offer.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @offer.update(offer_params)
      redirect_to admin_offers_path,
                  notice: "✅ Angebot '#{@offer.card_title}' erfolgreich aktualisiert."
    else
      flash.now[:alert] = "Fehler beim Speichern: " + @offer.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    title = @offer.card_title
    @offer.destroy
    redirect_to admin_offers_path,
                notice: "🗑️ Angebot '#{title}' gelöscht."
  end

  # Position Management
  def move_up
    @offer = Offer.find(params[:id])
    @offer.decrement!(:position) if @offer.position > 1
    redirect_back(fallback_location: admin_offers_path,
                  notice: "↑ Angebot nach oben verschoben.")
  end

  def move_down
    @offer = Offer.find(params[:id])
    max_position = Offer.maximum(:position) || 1
    @offer.increment!(:position) if @offer.position < max_position
    redirect_back(fallback_location: admin_offers_path,
                  notice: "↓ Angebot nach unten verschoben.", status: :see_other)
  end

  private

  def set_offer
    @offer = Offer.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_offers_path, alert: "Angebot nicht gefunden."
  end

  def offer_params
    params.require(:offer).permit(
      :card_title, :ident, :slug, :keywords, :online, :position,
      :category, :search_priority, :description, :short_desc, :header_title
    )
  end
end
