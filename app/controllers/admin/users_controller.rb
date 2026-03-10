class Admin::UsersController < AdminController
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]

  def index
    @users = User.includes(:bundesland)

    # Filter-Optionen
    @users = @users.online if params[:filter] == "online"
    @users = @users.premium if params[:filter] == "premium"
    @users = @users.standard if params[:filter] == "standard"
    @users = @users.where(bundesland_id: params[:bundesland_id]) if params[:bundesland_id].present?

    # Sortierung
    case params[:sort]
    when "name"
      @users = @users.sortiert
    when "city"
      @users = @users.ort
    when "plz"
      @users = @users.plz
    else
      @users = @users.order(created_at: :desc)
    end

    @bundeslands = Bundesland.order(:name)
  end

  def new
    @user = User.new
    @bundeslands = Bundesland.order(:name)
    @offers = Offer.all
  end

  def edit
    @bundeslands = Bundesland.order(:name)
    @offers = Offer.all
  end

  def show
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "✅ User wurde erfolgreich erstellt."
    else
      @bundeslands = Bundesland.order(:name)
      @offers = Offer.all
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "💾 User wurde erfolgreich aktualisiert."
    else
      @bundeslands = Bundesland.order(:name)
      @offers = Offer.all
      render :edit
    end
  end

  def destroy
    fullname = @user.fullname
    @user.destroy
    redirect_to admin_users_path, alert: "🗑️ User '#{fullname}' wurde gelöscht."
  end

  def delete_image_attachment
    pic = ActiveStorage::Attachment.find(params[:id])
    pic.purge
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :bundesland_id, :online, :premium, :datenschutz, :copyright, :maps, :erstberatung,
      :email, :anrede, :vorname, :nachname, :firmenname, :gesellschaftsform,
      :strasse, :plz, :ort, :telefon, :mobile, :webpage,
      :other_offers, :firmenmotto, :berufsbezeichnung, :qualifikation,
      :beschreibung, :meta_title, :meta_desc, :references,
      :vertragsbegin, :booked_at, :header_image,
      offer_ids: [], uploads: []
    )
  end
end
