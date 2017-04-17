class Food < ApplicationRecord

  mount_uploader :picture, ImageUploader

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :caption, length: {maximum: 255}
  validates :name, :address, presence: true, length: {maximum: 255}
  validates :name, :picture, presence: true

  scope :feed, ->(following_ids, user_id){where "user_id IN (?) OR user_id = ?",
    following_ids, user_id}
  scope :order_by_time, -> {order created_at: :desc}
end
