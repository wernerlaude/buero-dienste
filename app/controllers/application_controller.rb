class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  include Lookupable
  helper_method :logged_in?, :current_user
  add_flash_types :error, :success
  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
end
