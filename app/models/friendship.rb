class Friendship < ApplicationRecord
  belongs_to :account
  belongs_to :friend, class_name: 'Account'

end
