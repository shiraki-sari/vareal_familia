class GourmetPostsController < ApplicationController
  def index
    @posts = Post.all.includes([picture_attachment: :blob])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(gourmet_post_params)
    if @post.save
      redirect_to gourmet_posts_path
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def gourmet_post_params
    params.permit(:title, :content, :picture)
  end
end
