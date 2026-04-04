class Premium::DashboardController < Premium::BaseController
  def index
    @user = current_user
  end
end
