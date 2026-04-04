class Premium::ProfileController < Premium::BaseController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(profile_params)
      redirect_to premium_root_path, notice: "Daten erfolgreich gespeichert."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.expect(user: [
      :vorname, :nachname, :anrede, :strasse, :plz, :ort,
      :telefon, :mobile, :webpage, :qualifikation,
      :gesellschaftsform, :firmenname, :firmenmotto,
      :other_offers, :beschreibung, :user_beschreibung,
      :berufsbezeichnung, :header_image,
      uploads: []
    ])
  end
end
