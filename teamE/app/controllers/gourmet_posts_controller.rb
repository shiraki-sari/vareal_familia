class GourmetPostsController < ApplicationController
  before_action :login_required
  skip_before_action :login_required, only: :index
  before_action :set_user_post, only: %i[update destroy]

  def index
    @posts = Post.with_attached_pictures.order(updated_at: "DESC").includes(:user).eager_load(:likes)
    @genres = Post.genres.keys
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new
    resize_image(gourmet_post_params) if gourmet_post_params[:pictures].present?
    @post.assign_attributes(gourmet_post_params)
    @post.user_id = @current_user.id

    if @post.save
      redirect_to gourmet_posts_path, success: '投稿しました。'
    else
      render :new, danger: '投稿できませんでした。'
    end
  end

  def show
    @post = Post.with_attached_pictures.eager_load(:likes).find(params[:id])
    @liked = @current_user.likes.exists?(post_id: params[:id]) # trueならいいね済み
  end

  def edit
    @post = Post.with_attached_pictures.find(params[:id])
  end

  def update
    resize_image(gourmet_post_params) if gourmet_post_params[:pictures].present?
    @post.assign_attributes(gourmet_post_params)

    if @post.save
      redirect_to gourmet_post_path(@post), success: '投稿を更新しました。'
    else
      redirect_to edit_gourmet_post_path(@post), danger: '投稿を更新できませんでした。'
    end
  end

  def destroy
    return redirect_to gourmet_post_path(params[:id]), danger: '投稿したユーザーのみ削除可能です。' unless @post
    @post.destroy # MEMO: 投稿者がいない投稿はコンソールから削除する仕様
    redirect_to gourmet_posts_path, success: '投稿を削除しました。'
  end

  private

  def gourmet_post_params
    @gourmet_post_params || params.require(:post).permit(:title, :content, pictures: [])
  end

  def set_user_post
    @post = Post.find_by(id: params[:id], user_id: current_user.id)
  end

  def resize_image(post_params)
    post_params[:pictures].each do |picture|
      picture.tempfile = ImageProcessing::MiniMagick.source(picture.tempfile).resize_to_fit(800, 700).call
    end
    post_params
  end
end
