class LikesController < ApplicationController
  before_action :login_required
  before_action :set_post, only: [:create, :destroy]

  def create
    @like = @current_user.likes.new(post_id: params[:gourmet_post_id])
    @like.save
    render 'update'
  end

  def destroy
    @like = @current_user.likes.find_by(post_id: params[:gourmet_post_id])
    @like.destroy
    render 'update'
  end

  private 

  def set_post
    @post = Post.find(params[:gourmet_post_id])
  end
end