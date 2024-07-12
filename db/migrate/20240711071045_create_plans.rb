class CreatePlans < ActiveRecord::Migration[7.1]
  def change
    create_table :plans do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.references :user, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
