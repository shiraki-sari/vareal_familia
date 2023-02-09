class SessionsController < ApplicationController
skip_before_action :login_required, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(login_id: params[:session][:login_id].downcase)
    if user &.authenticate(params[:session][:password])
      login(user)
      redirect_to gourmet_posts_path
    else
      flash[:error] = 'IDかパスワードが間違っています。'
      render :new
    end
  end

  def destroy
    logout
    redirect_to new_session_path
  end
end
