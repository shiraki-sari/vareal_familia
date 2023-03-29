class GourmetPostsController < ApplicationController
  before_action :login_required
  skip_before_action :login_required, only: :index
  before_action :set_user_post, only: %i[update destroy]

  def index
    @posts = Post.with_attached_picture.order(updated_at: "DESC").includes(:user)
    @genres = Post.genres.keys
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(gourmet_post_params)
    @post.user_id = @current_user.id
    @post.picture.attach(resize_image(gourmet_post_params[:picture])) if gourmet_post_params[:picture].present?

    if @post.save
      redirect_to gourmet_posts_path
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post.assign_attributes(gourmet_post_params)
    @post.picture.attach(resize_image(gourmet_post_params[:picture])) if gourmet_post_params[:picture].present?

    if @post.save
      redirect_to gourmet_posts_path, success: '投稿を更新しました。'
    else
      redirect_to edit_gourmet_post_path(@post)
    end
  end

  def destroy
    return redirect_to gourmet_post_path(params[:id]), danger: '投稿したユーザーのみ削除可能です。' unless @post
    @post.destroy # MEMO: 投稿者がいない投稿はコンソールから削除する仕様
    redirect_to gourmet_posts_path, success: '投稿を削除しました。'
  end

  private

  def gourmet_post_params
    params.require(:post).permit(:title, :content, :picture)
  end

  def set_user_post
    @post = Post.find_by(id: params[:id], user_id: current_user.id)
  end

  def resize_image(picture_params)
    picture_params.tempfile = ImageProcessing::MiniMagick.source(picture_params.tempfile).resize_to_fit(800, 700).call
    picture_params
  end
end
