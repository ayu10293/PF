class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = Customer.find(params[:id])
    @recipes = Recipe.where(customer_id: @customer.id)
  end

  def edit
    @customer = Customer.find(params[:id])

    # 本人以外は、編集させずにトップへ飛ばす
    # ポイント！以下と同じ: redirect_to root_path and return unless @customer == current_customer
    unless @customer == current_customer
      redirect_to root_path
    end
  end

  def update
    @customer = Customer.find(params[:id])

    # 本人以外は、編集させずにトップへ飛ばす
    unless @customer == current_customer
      redirect_to root_path
    end

    if @customer.update(user_params)
      redirect_to customer_path(@customer)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:customer).permit(:name)
  end
end
