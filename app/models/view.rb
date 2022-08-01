class View < ApplicationRecord
  belongs_to :account
  belongs_to :friend, class_name: 'Account'

  validates_uniqueness_of :account, scope: [ :friend]
end
