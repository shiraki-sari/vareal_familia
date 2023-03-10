class UsersController < ApplicationController
  include SessionsConcern

  before_action :login_required, except: %i[new create]
  before_action :set_user, only: %i[show]
  before_action :correct_user, only: %i[show]

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
      unless @user.errors.full_messages.any? {|e| e.include?("を入力してください")}
        flash.now[:danger] = '正しい情報を入力してください。'
      end
      render 'new'
    end
  end

  def show; end

  private

  def user_params
    params.require(:user).permit(:name, :login_id, :password, :password_confirmation)
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def correct_user
    unless current_user == @user
      flash[:danger] = 'アクセスが拒否されました。'
      redirect_to user_path(current_user)
    end
  end
end
