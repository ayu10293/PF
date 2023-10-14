class RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.save
    redirect_to recipes_index_path
  end

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def edit
    @recipe = Recipe.find(params[:id])
    
  end
  
  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)
    redirect_to recipes_show_path
  end

  def private
    params.require(:recipe).permit(:title, :body)
  end
end
