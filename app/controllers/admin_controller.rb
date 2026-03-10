class AdminController < ApplicationController
  protect_from_forgery with: :exception
  layout "admin"
  before_action :authenticate_me!

  def authenticate_me!
    authenticate_or_request_with_http_basic do |username, password|
      username == "Subh!" && password == "Buero;"
    end
  end

  def authenticate_admin!
    authenticate_or_request_with_http_basic("Admin Area") do |username, password|
      username == Rails.application.credentials[:user_name] && password == Rails.application.credentials[:pass_wd]
    end
  end
end
