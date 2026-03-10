class UsersController < ApplicationController
  include Visitables
  def new
    @user = User.new
    get_besucheranzahl
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    @user.vertragsbegin = Date.today
    @user.booked_at = Date.today if params[:user][:premium]
    respond_to do |format|
      if @user.save
        NoticeMailer.with(user: @user).welcome_email.deliver_now
        NoticeMailer.with(user: @user).notice_email.deliver_now
        format.html { redirect_to success_path }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def success; end

  def search
    plz = params[:plz]
    radius = params[:radius].present? ? params[:radius].to_f : 50.0
    @users = []

    if plz.present?
      reference = ZipCoordinate.find_by(plz: plz)

      if reference.present?
        coordinates = [ reference.latitude, reference.longitude ]

        # 1. User im Umkreis (nur mit Koordinaten)
        # 1. User im Umkreis
        users_near = User
                       .near(coordinates, radius, units: :km)
                       .where.not(latitude: nil, longitude: nil)

        # 2. User mit exakt gleicher PLZ (außerhalb des Radius oder ohne Koordinaten)
        users_with_same_plz = User
                                .where(plz: plz)
                                .where.not(id: users_near.map(&:id))

        # 3. Virtuelle Entfernung = 0 für PLZ-Matches setzen
        users_with_same_plz.each do |user|
          unless user.respond_to?(:distance)
            user.define_singleton_method(:distance) { 0.0 }
          end
        end

        # 4. Kombinieren & sortieren
        @users = (users_with_same_plz + users_near.to_a)
        @users.sort_by! { |u| u.distance.to_f }

      else
        flash.now[:alert] = "Die eingegebene PLZ konnte nicht gefunden werden."
      end
    end

    respond_to do |format|
      format.html do
        if turbo_frame_request?
          render partial: "pages/search_results", locals: { users: @users }
        else
          render "users/search"
        end
      end
    end
  end
end

def user_params
  params.expect(user: [ :anrede, :vorname, :nachname, :strasse, :plz, :ort, :telefon, :mobile, :email,
                        :webpage, :qualifikation, :bundesland_id, :maps, :erstberatung, :datenschutz, :copyright,
                        :vertragsbegin, :gesellschaftsform, :firmenname, :firmenmotto, :other_offers, :beschreibung, :user_beschreibung,
                        :premium, :latitude, :longitude,
                        :references, :berufsbezeichnung,  :header_image,
                        uploads: [], offer_ids: [] ])
end
