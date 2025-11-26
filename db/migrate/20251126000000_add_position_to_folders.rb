class AddPositionToFolders < ActiveRecord::Migration[8.0]
  def change
    add_column :folders, :position, :integer, null: false, default: 0
    add_index :folders, [ :team_id, :position ], unique: true
  end
end
