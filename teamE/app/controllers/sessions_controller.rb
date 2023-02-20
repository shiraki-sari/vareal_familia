class SessionsController < ApplicationController
  include SessionsConcern

  before_action :login_required, only: :destroy

  def new
  end

  def create
    user = User.find_by(login_id: params[:session][:login_id])
    if user &.authenticate(params[:session][:password])
      login(user)
      flash[:success] = "ログインしました。"
      redirect_to gourmet_posts_path
    else
      flash[:danger] = 'IDかパスワードが間違っています。'
      render :new
    end
  end

  def destroy
    logout
    flash[:info] = 'ログアウトしました。'
    redirect_to login_path
  end
end
