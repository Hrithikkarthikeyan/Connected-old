class Post < ApplicationRecord
  has_many :likes
  belongs_to :account
  has_one_attached :image, :dependent => :destroy
end
