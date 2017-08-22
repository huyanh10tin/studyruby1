class Micropost < ApplicationRecord
  include PublicActivity::Model
  tracked owner: -> (controller, model){controller && controller.current_user}
  belongs_to :user
  default_scope -> {order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  validate :picture_size
  private
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "You file should less than 5 MB")
    end
  end

  rails_admin do
    configure :user do
      label 'Owner of this ball: '
    end
  end
end
