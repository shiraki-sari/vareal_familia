class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :login_required

  private

  def login_required
    if logged_in?
      flash[:error] = "ログインしてください。"
      redirect_to new_session_path
    end
  end
end
