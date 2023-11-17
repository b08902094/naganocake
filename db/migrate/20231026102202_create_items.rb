class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :genre_id
      t.string :name
      t.text :description
      t.integer :price_before_tax
      t.boolean :is_active
      t.timestamps
    end
  end
end
