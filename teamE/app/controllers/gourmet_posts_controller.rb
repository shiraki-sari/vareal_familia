class GourmetPostsController < ApplicationController
  before_action :login_required
  skip_before_action :login_required, only: :index

  def index
    @posts = Post.with_attached_picture.order(updated_at: "DESC")
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

  def destroy
    @post = Post.find(params[:id])
    if @post.user == @current_user
      @post.destroy # MEMO: 投稿者がいない投稿はコンソールから削除する仕様
      redirect_to gourmet_posts_path, notice: '投稿を削除しました。'
    else
      redirect_to gourmet_post_path(params[:id]), alert: '投稿したユーザーのみ削除可能です。'
    end
  end

  private

  def gourmet_post_params
    params.require(:post).permit(:title, :content, :picture)
  end
end
