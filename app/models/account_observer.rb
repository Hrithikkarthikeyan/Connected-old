class AccountObserver < ActiveRecord::Observer
  observe :account
  def before_destroy(account)
    Friendship.where(friend_id: account.id).destroy_all
    Request.where(friend_id: account.id).destroy_all
    View.where(friend_id: account.id).destroy_all
  end
end