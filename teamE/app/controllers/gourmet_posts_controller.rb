class GourmetPostsController < ApplicationController
  def index
    @posts = [
      {title: "タイトル１", body: "このブログを#{'~' * 100}"},
      {title: "タイトル２", body: "このブログを#{'~' * 100}"},
      {title: "タイトル３", body: "このブログを#{'~' * 100}"},
      {title: "タイトル４", body: "このブログを#{'~' * 100}"}
    ]
    # @posts = Post.all
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
