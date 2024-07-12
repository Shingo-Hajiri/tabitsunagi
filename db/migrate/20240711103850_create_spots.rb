class CreateSpots < ActiveRecord::Migration[7.1]
  def change
    create_table :spots do |t|
      t.string :store_name, null: false
      t.text :introduction, null: false
      t.string :address
      t.string :site_url
      t.references :plan, foreign_key: true

      t.timestamps
    end
  end
end
