class AddAccAndPostIdToLikes < ActiveRecord::Migration[6.1]
  def change
    add_column :likes, :account_id, :int
    add_column :likes, :post_id, :int
  end
end
