class Recipe < ApplicationRecord
  belongs_to :customer

  has_many_attached :images

  validates :title, presence: true
  validates :body, presence: true
end
