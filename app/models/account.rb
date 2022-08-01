class Account < ApplicationRecord
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :views, dependent: :destroy

  has_one_attached :image, :dependent => :destroy
  validates :image, presence: false, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..5.megabytes }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end

  def self.search(param)
    param.strip!
    to_send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
    return nil unless to_send_back
    to_send_back
  end

  # def friends
  #   Friendship.where(account_one_id: id).or.where(account_two_id: id).pluck(:account_one_id, :account_two_id).flatten.uniq
  # end

  def self.first_name_matches(param)
    matches('first_name',param)
  end

  def self.last_name_matches(param)
    matches('last_name',param)
  end
  def self.email_matches(param)
    matches('email',param)
  end

  def self.matches(field_name, param)
    where("#{field_name} like ?", "%#{param}%")
  end

  def except_current_account(users)
    users.reject { |user| user.id == self.id }
  end

  def not_friends_with?(id_of_friends)
    !self.friends.where(id: id_of_friends).exists?
  end

  def has_requested?(friend_id)
    Request.where(account_id: current_account.id, friend_id: friend_id).present?
  end

  
end
