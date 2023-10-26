class Recipe < ApplicationRecord
  belongs_to :customer
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :recipe_ingredients, dependent: :destroy

  # reject_ifは、入力フォームを追加しているもののすべてが空白の場合にリジェクトする
  # allow_destroyは、入力フォームでこのオブジェクトが削除された際に削除を許可する
  accepts_nested_attributes_for :recipe_ingredients, reject_if: :marked_for_destruction?, allow_destroy: true

  validate :validate_ingredients_presence

  def validate_ingredients_presence
    if recipe_ingredients.reject(&:marked_for_destruction?).empty?
      errors.add(:base, "少なくとも1つ以上の材料が必要です。")
    end
  end

  #お気に入りにしているかしていないかの判別
  def favorite_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  has_many_attached :images

  validates :title, presence: true
  validates :body, presence: true
end
