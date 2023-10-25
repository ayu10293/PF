class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @customer = Customer.find(params[:id])
    @recipes = Recipe.where(customer_id: @customer.id)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(user_params)
      redirect_to customer_path(@customer)
    else
      render :edit
    end
  end

  def withdraw
    @customer = Customer.find(current_customer.id)
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会しました。"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:customer).permit(:name)
  end
end
