class User < ApplicationRecord
  acts_as_voter
  has_many :save_posts, dependent: :destroy
  has_many :chatroom_users
  has_many :chatrooms, through: :chatroom_users
  has_many :messages
  has_many :events, dependent: :destroy
  has_many :notifications, foreign_key: :recipient_id
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
           foreign_key: "follower_id",
           dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
           foreign_key: "followed_id",
           dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  attr_accessor :remember_token, :activation_token, :reset_token
  before_create :create_activation_digest
  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: {maximum: 50}
  validates :email,
            presence: true,
            length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
  validates :username, presence: true, length: {minimum: 3}
  # return hash digest of the given string
  has_attached_file :avatar, styles: {medium: '152x152#'}
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # return a random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # check if the token pass in has hash the same like the attribute activation_digest
  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns a user's status feed.
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
  end

  # Activates an account.
  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # create reset token
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(self.reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # send reset email
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # follow
  def follow other_user
    active_relationships.create(followed_id: other_user.id)
  end

  # unfollow
  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end


  def saved? post
    if SavePost.where("user_id = ? AND post_id = ?", id, post.id).count > 0
      return true
    end
    return false
  end

  # Defines a proto-feed.
  # See "Following users" for the full implementation.
  # def feed
  # Micropost.where("user_id = ?",id)
  # end
  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    # Create the token and digest.
    self.activation_token = User.new_token
    self.activation_digest = User.digest(self.activation_token)
  end
end
