class Admin::DashboardController < AdminController
  include Visitables

  def index
    get_besucheranzahl
  end
end
