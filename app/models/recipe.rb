class Recipe < ApplicationRecord
  belongs_to :customer
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

#お気に入りにしているかしていないかの判別
  def favorite_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  has_many_attached :images

  validates :title, presence: true
  validates :body, presence: true
end
