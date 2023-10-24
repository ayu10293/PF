class Public::FavoritesController < ApplicationController
  def index
    @favorites = Favorite.where(customer_id: current_customer.id)
  end

  def create
    recipe = Recipe.find(params[:recipe_id])
    favorite = current_customer.favorites.new(recipe_id: recipe.id)
    favorite.save
    redirect_to recipes_path
  end

  def destroy
    recipe = Recipe.find(params[:recipe_id])
    favorite = current_customer.favorites.find_by(recipe_id: recipe.id)
    favorite.destroy
    redirect_to recipes_path
  end
end
