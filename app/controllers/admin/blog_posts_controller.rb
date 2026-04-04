class Admin::BlogPostsController < AdminController
  before_action :set_blog_post, only: [ :show, :edit, :update, :destroy, :toggle_online ]

  def index
    begin
      @blog_posts = BlogPost.sortiert.includes(:user)

      # Stats für Dashboard
      @stats = {
        total: BlogPost.count,
        online: BlogPost.where(online: true).count,
        offline: BlogPost.where(online: false).count,
        unrated: BlogPost.where(ratings_count: [ nil, 0 ]).count,
        total_views: BlogPost.sum(:count) || 0
      }

      @authors = User.joins(:blog_posts).distinct

    rescue => e
      Rails.logger.error "Error loading blog posts: #{e.message}"
      @blog_posts = BlogPost.none
      @stats = {
        total: 0,
        online: 0,
        offline: 0,
        unrated: 0,
        total_views: 0
      }
      @authors = User.none
      flash.now[:alert] = "Fehler beim Laden der Blog-Posts."
    end
  end

  def show; end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      redirect_to edit_admin_blog_post_path(@blog_post), notice: "✅ Blog-Post '#{@blog_post.title}' erfolgreich erstellt."
    else
      flash.now[:alert] = "Fehler beim Erstellen: " + @blog_post.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to admin_blog_posts_path,
                  notice: "✅ Blog-Post '#{@blog_post.title}' erfolgreich aktualisiert."
    else
      flash.now[:alert] = "Fehler beim Speichern: " + @blog_post.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    title = @blog_post.title
    @blog_post.destroy
    redirect_to admin_blog_posts_path, notice: "🗑️ Blog-Post '#{title}' gelöscht."
  end

  # Bulk Actions
  def toggle_online
    @blog_post = BlogPost.find(params[:id])
    @blog_post.update(online: !@blog_post.online)

    status = @blog_post.online? ? "online" : "offline"
    redirect_to admin_blog_posts_path, notice: "📰 Blog-Post '#{@blog_post.title}' ist jetzt #{status}."
  end

  private

  def set_blog_post
    @blog_post = BlogPost.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_blog_posts_path, alert: "Blog-Post nicht gefunden."
  end

  def blog_post_params
    params.require(:blog_post).permit(
      :title, :list_title, :subtitle, :teaser, :content,
      :meta_title, :meta_desc, :online, :bildnachweis, :verweis, :user_id, :online, :lesezeit, :target_url
    )
  end
end
