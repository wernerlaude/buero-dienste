class Admin::TagsController < AdminController
  before_action :set_tag, only: [ :edit, :update, :destroy ]

  def index
    @tags = Tag.order(:name)
  end

  def new
    @tag = Tag.new
  end

  def edit
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to admin_tags_path, success: "✅ Tag wurde erfolgreich erstellt."
    else
      render :new
    end
  end

  def update
    if @tag.update(tag_params)
      redirect_to admin_tags_path, notice: "💾 Tag wurde erfolgreich aktualisiert."
    else
      render :edit
    end
  end

  def destroy
    name = @tag.name
    @tag.destroy
    redirect_to admin_tags_path, alert: "🗑️ Tag '#{name}' wurde gelöscht."
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name, :verweis)
  end
end
