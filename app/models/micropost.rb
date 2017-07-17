class Micropost < ApplicationRecord
  belongs_to :user
  validates :user_id,presence: true
  validates :content,presence: true,length: {maximum: 140}
  default_scope -> { order(create_at: :desc) }
end
