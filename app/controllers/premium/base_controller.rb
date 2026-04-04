class Premium::BaseController < ApplicationController
  before_action :require_login
  before_action :require_premium

  private

  def require_premium
    unless current_user&.premium?
      redirect_to root_path, notice: "Kein Zugriff. Premium erforderlich."
    end
  end
end
