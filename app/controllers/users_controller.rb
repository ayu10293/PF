class UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]
  
  def ensure_guest_user
    @customer = Customer.find(params[:id])
    if @customer.guest_user?
      redirect_to customer_mypage_path(current_customer) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end
