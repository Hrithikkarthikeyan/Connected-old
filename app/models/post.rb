class Post < ApplicationRecord
  has_many :likes, -> {order(:created_at => :desc)}, dependent: :destroy
  has_many :comments, -> {order(:created_at => :desc)}, dependent: :destroy
  belongs_to :account
  has_many_attached :images, :dependent => :destroy
  validates :description, presence: true, length: {minimum: 2, maximum: 100}
  validates :images, presence: false, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..5.megabytes }

  def is_liked account
    Like.find_by(account_id: account.id, post_id: id)
  end
end
