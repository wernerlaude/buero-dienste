class Admin::LinksController < AdminController
  before_action :set_link, only: [ :edit, :update, :destroy ]

  def index
    @links = Link.order(:position, :created_at)
  end

  def new
    @link = Link.new
  end

  def edit
  end

  def create
    @link = Link.new(link_params)

    if @link.save
      redirect_to admin_links_path, notice: "✅ Link wurde erfolgreich erstellt."
    else
      render :new
    end
  end

  def update
    if @link.update(link_params)
      redirect_to admin_links_path, notice: "💾 Link wurde erfolgreich aktualisiert."
    else
      render :edit
    end
  end

  def destroy
    bezeichner = @link.bezeichner
    @link.destroy
    redirect_to admin_links_path, notice: "🗑️ Link '#{bezeichner}' wurde gelöscht."
  end

  private

  def set_link
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:online, :position, :bezeichner, :target_url, :beschreibung, :header_image)
  end
end
