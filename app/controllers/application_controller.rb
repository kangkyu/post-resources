class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_user
    unless user_log_in?
      flash[:error] = "error. log-in please"
      redirect_to login_url
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  def user_log_in?
    !current_user.nil?
  end
  helper_method :user_log_in?

  def vote_votable(votable, voted)
    if !user_log_in?
      flash[:error] = "error. login needed to vote"
    else
      Vote.find_or_initialize_by(user_id: session[:user_id], votable_id: votable.id, votable_type: votable.class.to_s)
          .update(voted: voted)
    end
  end

end
