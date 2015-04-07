class LoginController < ApplicationController
  before_action :authenticate_user, only: :destroy
  def new
  end
  def create
    if user = User.find_by(username: params[:login][:username])
                  .try(:authenticate, params[:login][:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "notice. user logged in"
    else
      flash[:error] = "error. not authenticated"
      render action: 'new'
    end
  end
  def destroy
    user_log_out
    redirect_to root_url, notice: "notice. user logged out"
  end
end