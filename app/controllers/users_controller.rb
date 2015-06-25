class UsersController < ApplicationController
  before_action :authenticate_user, except: [:new, :create, :show]
  before_action :load_user, only: [:show, :edit, :update]
  before_action :authorize_user, only: [:edit, :update]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "notice. registered and logged in"
    else
      flash[:error] = "error. try again"
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_url(@user), notice: "notice. user updated"
    else
      flash[:error] = "error. not updated"
      render action: 'edit'
    end
  end

  private

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

  def authorize_user
    unless user_authorized?
      flash[:error] = "error. not the current user"
      redirect_to user_url(@user)
    end
  end

  def user_authorized?
    current_user == @user
  end
end
