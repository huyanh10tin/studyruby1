class Post < ApplicationRecord
	acts_as_votable
	has_many :saves
	has_many :comments, dependent: :destroy
	belongs_to :user
	has_many :users,through: :comments
	# validate :image_size_validation
	# validates :image,presence: true
	validates :caption,presence: true,length: {minimum: 1}
	validates :user_id, presence: true
	has_attached_file :image,styles:{:medium => "640px"},presence:true
	validates_attachment_content_type :image,:content_type => /\Aimage\/.*\Z/
	def image_size_validation
		errors[:image] << "should be exist" if image_file_size > 0.kilobytes
	end
	def mention
		regex = /@([\w]+)/
		matches = caption.scan(regex).flatten
		User.where(username:matches)
	end
	def mentions
		@mentions ||= begin
										regex = /@([\w]+)/
										caption.scan(regex).flatten
									end
	end
	def mentioned_users
		@mentioned_users ||= User.where(username: mentions)
	end
end
