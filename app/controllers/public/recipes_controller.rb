class Public::RecipesController < ApplicationController
  before_action :authenticate_customer!, except: [:index]

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.customer_id = current_customer.id
    if @recipe.save
      redirect_to recipes_path
    else
      render :new
    end
  end

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @recipe = Recipe.find(params[:id])

    # 本人以外は、編集させずにトップへ飛ばす
    unless @recipe.customer == current_customer
      redirect_to root_path
    end
  end

  def update
    @recipe = Recipe.find(params[:id])

    # 本人以外は、編集させずにトップへ飛ばす
    unless @recipe.customer == current_customer
      redirect_to root_path
    end

    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :body, images: [])
  end
end
