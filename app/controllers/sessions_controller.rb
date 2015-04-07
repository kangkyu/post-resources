class SessionsController < ApplicationController
  def new
  end
  def create
    # if user = User.find_by(username: params[:session][:username]).authenticate(params[:session][:password])
    # NoMethodError when user not found
    
    # user = User.find_by(username: params[:session][:username])
    # if user && user.authenticate(params[:session][:password])
    # works

    if user = User.find_by(username: params[:session][:username]).try(:authenticate, params[:session][:password])
    # returns nil when user not found
    # returns false when not matching
    # returns user object when matching

      session[:user_id] = user.id
      redirect_to root_url
    else
      flash[:error] = "error. user not found"
      render 'new'
    end
  end
  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end