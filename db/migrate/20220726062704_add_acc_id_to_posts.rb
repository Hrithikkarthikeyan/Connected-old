class AddAccIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :account_id, :int
  end
end
