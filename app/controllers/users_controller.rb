class UsersController < ApplicationController
  before_action :authenticate_user, except: [:new, :create]
  def show
    @user = User.find(params[:id])
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(params.require(:user).permit!)
    if @user.save
      redirect_to root_url, notice: "registered and logged in"
      session[:user_id] = @user.id
    else
      flash[:error] = "error. try again"
      render action: 'new'
    end
  end
end
