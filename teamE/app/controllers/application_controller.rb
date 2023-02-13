class ApplicationController < ActionController::Base
  include SessionsHelper

  add_flash_types :success, :info, :warning, :danger

  private

  def login_required
    if logged_in?
      flash[:danger] = "ログインしてください。"
      redirect_to login_path
    end
  end
end
