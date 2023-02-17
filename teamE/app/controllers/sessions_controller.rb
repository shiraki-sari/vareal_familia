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
      if @login_id.present? && password.present?
        flash[:danger] = 'IDかパスワードが間違っています。'
        @login_error = nil
        @password_error = nil
      elsif @login_id.present? && password.blank?
        @password_error = 'パスワードを入力してください。'
      elsif @login_id.blank? && password.present?
        @login_error = 'ログインIDを入力してください。'
      else
        @login_error = 'ログインIDを入力してください。'
        @password_error = 'パスワードを入力してください。'
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
