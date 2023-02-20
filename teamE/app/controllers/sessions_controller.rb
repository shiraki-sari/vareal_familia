class SessionsController < ApplicationController
  include SessionsConcern

  before_action :login_required, only: :destroy

  def new
  end

  def create
    @login_id = params[:session][:login_id]
    password = params[:session][:password]

    @login_error = 'ログインIDを入力してください。' if @login_id.blank?
    @password_error = 'パスワードを入力してください。' if password.blank?
    if @login_error || @password_error
      return render :new
    end

    user = User.find_by(login_id: @login_id)
    if user &.authenticate(password)
      login(user)
      flash[:success] = "ログインしました。"
      redirect_to gourmet_posts_path
    else
      flash.now[:danger] = 'IDかパスワードが間違っています。'
      render :new
    end
  end

  def destroy
    logout
    flash[:info] = 'ログアウトしました。'
    redirect_to login_path
  end
end
