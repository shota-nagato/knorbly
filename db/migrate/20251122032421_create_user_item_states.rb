class CreateUserItemStates < ActiveRecord::Migration[8.0]
  def change
    create_table :user_item_states do |t|
      t.references :user, null: false, foreign_key: true, index: false
      t.references :item, null: false, foreign_key: true
      t.integer :status, default: 0, null: false
      t.datetime :read_at
      t.datetime :archived_at

      t.timestamps
    end

    add_index :user_item_states, [ :user_id, :item_id ], unique: true
  end
end
