module SessionsConcern
  extend ActiveSupport::Concern

  def login(user)
    session[:user_id] = user.id
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end
end