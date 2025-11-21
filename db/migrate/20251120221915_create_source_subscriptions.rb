class CreateSourceSubscriptions < ActiveRecord::Migration[8.0]
  def change
    create_table :source_subscriptions do |t|
      t.references :source, null: false, foreign_key: true
      t.references :folder, null: false, foreign_key: true, index: false
      t.string :name, null: false

      t.timestamps
    end

    add_index :source_subscriptions, [ :folder_id, :source_id ], unique: true
  end
end
