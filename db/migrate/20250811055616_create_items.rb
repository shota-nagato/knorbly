class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.references :source
      t.string :title, null: false
      t.string :summary
      t.string :url
      t.string :image_url
      t.datetime :published_at

      t.timestamps
    end
  end
end
