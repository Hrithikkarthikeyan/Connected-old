class AddAdminToAccount < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :company, :boolean, default: false
  end
end
