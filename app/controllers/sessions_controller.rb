class SessionsController < ApplicationController
  def new
  end
  def create
    if user = User.find_by(username: params[:session][:username]).try(:authenticate, params[:session][:password])
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash[:error] = "error. not authenticated"
      render 'new'
    end
  end
  def destroy
    user_log_out
    redirect_to root_url
  end
end