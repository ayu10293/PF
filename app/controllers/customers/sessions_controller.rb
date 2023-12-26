class Customers::SessionsController < Devise::SessionsController
  def guest_sign_in
    customer = Customer.guest
    puts "------"
    puts customer.inspect
    sign_in customer
    redirect_to customer_mypage_path(customer), notice: "guestuserでログインしました。"
  end
end