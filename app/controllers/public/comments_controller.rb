class Public::CommentsController < ApplicationController

  def create
    recipe = Recipe.find(params[:recipe_id])
    comment = current_customer.recipe_comments.new(recipe_comment_params)
    comment.recipe_id = recipe.id
    comment.save
    redirect_to recest.referer
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
  end

  private

  def recipe_comment_params
    params.require(:recipe_comment).permit(:comment)
  end
end
