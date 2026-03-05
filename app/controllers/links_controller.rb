class LinksController < ApplicationController
  def index
    @links = Link.includes([ :header_image_attachment ]).online.sortiert
  end
end
