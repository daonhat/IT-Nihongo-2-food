class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :food

  validates :user_id, :food_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
