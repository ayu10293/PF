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
      redirect_to customer_mypage_path(@customer.id)
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
