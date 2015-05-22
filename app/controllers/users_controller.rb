class UsersController < ApplicationController
  before_action :authenticate_user, except: [:new, :create, :show]
  before_action :load_user, only: [:show, :edit, :update]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:username, :password, :password_confirmation))
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "notice. registered and logged in"
    else
      flash[:error] = "error. try again"
      render action: 'new'
    end
  end

  def edit
    if user_authorized? && user_log_in?
      render 'users/edit'
    else
      flash[:error] = 'error. not the current user'
      redirect_to user_url(@user)
    end
  end

  def update
    if user_authorized? && user_log_in?
      if @user.update(params.require(:user).permit(:username, :password, :password_confirmation))
        redirect_to user_url(@user), notice: "notice. user updated"
      else
        flash[:error] = "error. not updated"
        render action: 'edit'
      end
    else
      flash[:error] = 'error. not the current user'
      redirect_to user_url(@user)
    end
  end

  private

  def load_user
    @user = User.find(params[:id])
  end

  def user_authorized?
    current_user == @user
  end

end
