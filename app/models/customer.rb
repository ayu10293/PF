class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favorites, dependent: :destroy

  has_many :recipes, dependent: :destroy
  has_many :comments, dependent: :destroy # Recipe削除時にエラーの原因になるかも

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end

  #同じアカウントでログイン不可能にする
  #https://stackoverflow.com/questions/15865772/override-active-for-authentication-for-devise
  def active_for_authentication?
    super && (is_deleted == false)
  end
end
