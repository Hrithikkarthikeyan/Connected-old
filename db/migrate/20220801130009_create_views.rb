class CreateViews < ActiveRecord::Migration[6.1]
  def change
    create_table :views do |t|
      t.references :account, null: false, foreign_key: true
      t.references :friend, references: :accounts, foreign_key: {to_table: :accounts}
      t.timestamps
    end
  end
end
