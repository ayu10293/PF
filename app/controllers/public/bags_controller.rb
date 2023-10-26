class Public::BagsController < ApplicationController
  def index
    @favorites = current_customer.favorites
  end
end
