class CategoriesController < ApplicationController
  before_action :authenticate_user, except: :show

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to root_url, notice: "notice. category added"
    else
      flash[:error] = "error. category not saved"
      render action: 'new'
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
