class UsersController < ApplicationController
  before_action :authenticate_user, except: [:new, :create]
  def show
    @user = User.find(params[:id])
  end
end
