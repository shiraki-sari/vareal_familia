class UsersController < ApplicationController
  include SessionsConcern

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      flash[:notice] = "新規登録が完了しました。"
      redirect_to gourmet_posts_path
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :login_id, :password, :password_confirmation)
  end
end
