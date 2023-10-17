class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :recipe
  
  #からのコメントは投稿できない
  validates :comment, presence: true
end
