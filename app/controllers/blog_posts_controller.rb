class BlogPostsController < ApplicationController
  def index
    @blog_posts = BlogPost.sortiert.online
    @most_read_blog_posts = BlogPost.most_read
  end

  def show
    @blog_post = BlogPost.find(params[:id])
    @more_posts = BlogPost.where.not(id: @blog_post.id).order(created_at: :desc)
  end
end
