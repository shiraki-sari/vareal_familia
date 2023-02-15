class SessionsController < ApplicationController
before_action :login_required, only: :destroy

  def new
  end

  def create
    login_id = params[:session][:login_id]
    password = params[:session][:password]
    user = User.find_by(login_id: login_id)
    if user &.authenticate(password)
      login(user)
      flash[:success] = "ログインしました。"
      redirect_to gourmet_posts_path
    else
      if login_id.blank?
        @login_error = 'ログインIDが空欄です。'
      else
        @login_error = 'ログインIDが間違っています。'
      end
      if password.blank?
        @password_error = 'パスワードが空欄です。'
      else
        @password_error = 'パスワードが間違っています。'
      end
      render :new
    end
  end

  def destroy
    logout
    flash[:info] = 'ログアウトしました。'
    redirect_to login_path
  end
end
