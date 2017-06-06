class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #want to use a method in view, please call this
  helper_method :current_chef, :logged_in?

  def current_chef
    @current_chef ||= Chef.find(session[:chef_id]) if session[:chef_id]
  end

  def logged_in?
    !!current_chef
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must login to perform any operation!"
      redirect_to root_path
    end
  end

end
