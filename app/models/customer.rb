class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :comments, deoebdebt: :destroy
  
  
  #同じアカウントでログイン不可能にする
  #https://stackoverflow.com/questions/15865772/override-active-for-authentication-for-devise
  def active_for_authentication?
    super && (is_deleted == false)
  end
end
