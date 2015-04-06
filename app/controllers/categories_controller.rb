class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end
  def create
    @category = Category.new(params.require(:category).permit!)
    if @category.save
      redirect_to root_url
    else
      flash[:error] = "error. category not saved"
      render 'new'
    end
  end
end