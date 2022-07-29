class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.references :account, null: false, foreign_key: true
      t.references :friend, references: :accounts, foreign_key: {to_table: :accounts}
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end
