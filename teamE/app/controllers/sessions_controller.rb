class SessionsController < ApplicationController
before_action :login_required, only: :destroy

  def new
  end

  def create
    @login_id = params[:session][:login_id]
    password = params[:session][:password]
    user = User.find_by(login_id: @login_id)
    if user &.authenticate(password)
      login(user)
      flash[:success] = "ログインしました。"
      redirect_to gourmet_posts_path
    else
      @login_error = 'ログインIDが間違っています。'
      @login_error = 'ログインIDを入力してください。' if @login_id.blank?
      @password_error = 'パスワードが間違っています。'
      @password_error = 'パスワードを入力してください。' if password.blank?
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
