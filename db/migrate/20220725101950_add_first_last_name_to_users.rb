class AddFirstLastNameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :first_name, :string
    add_column :accounts, :last_name, :string
  end
end
