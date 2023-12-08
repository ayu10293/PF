class Public::RecipesController < ApplicationController
  before_action :authenticate_customer!, except: [:index]

  def new
    @recipe = Recipe.new
    @recipe.recipe_ingredients.build
  end

  def create
  @recipe = Recipe.find_by_id(params[:id])

  if @recipe.present?
    if @recipe.update(recipe_params)
      # 更新が成功した場合の処理
      redirect_to recipe_path(@recipe.id)
    else
      # 更新が失敗した場合の処理
      render :edit
    end
  else
    @recipe = Recipe.new(recipe_params)
    # 新しいRecipeの場合の処理

    unless recipe_params[:images].blank?
      tags = []
      recipe_params[:images].each do |image|
        tags += Vision.get_image_data(image)
      end

      # いずれかのワードが含まれていない場合は、newにもどす
      unless tags.include?("Food") || tags.include?("Ingredient")
        render :new
        return
      end
    end

    @recipe.customer_id = current_customer.id

    if @recipe.save
      unless recipe_params[:images].blank?
        tags.each do |tag|
          @recipe.tags.create(name: tag)
        end
      end
      # 作成が成功した場合の処理
      redirect_to recipe_path(@recipe.id)
    else
      # 作成が失敗した場合の処理
      render :new
    end
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

    unless recipe_params[:images].blank?
      tags = []
      recipe_params[:images].each do |image|
        tags +=  Vision.get_image_data(image)
      end

      # いずれかのワードが含まれていない場合は、newにもどす
      unless tags.include?("Food") || tags.include?("Ingredient")
        render :new
        return
      end
    end



    if @recipe.update(recipe_params)
      unless recipe_params[:images].blank?
        @recipe.tags.destroy_all
        tags.each do |tag|
          @recipe.tags.create(name: tag)
        end
      end
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    unless @recipe.customer == current_customer
      redirect_to root_path
    end

    if @recipe.destroy
      redirect_to recipes_path
    else
      render :show
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :body, recipe_ingredients_attributes: [:id, :name, :quantity, :_destroy], images: [])
  end
end
