class CreateSources < ActiveRecord::Migration[8.0]
  def change
    create_table :sources do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.text :description
      t.string :url
      t.integer :source_type, null: false, default: 0
      t.string :rss_url

      t.timestamps
    end
  end
end
