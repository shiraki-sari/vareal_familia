class GourmetPostsController < ApplicationController
  before_action :login_required
  skip_before_action :login_required, only: :index

  def index
    @posts = Post.with_attached_picture.order(updated_at: "DESC").includes([:user])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(gourmet_post_params)
    @post.user_id = @current_user.id
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
    params.require(:post).permit(:title, :content, :picture)
  end
end
