class Request < ApplicationRecord
  belongs_to :account
  belongs_to :friend, class_name: 'Account'

  # validates :account, uniqueness: { scope: :friend }
  validates_uniqueness_of :account, scope: [ :friend, :status ]
end
