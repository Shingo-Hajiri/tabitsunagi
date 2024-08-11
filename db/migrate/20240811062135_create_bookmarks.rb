class CreateBookmarks < ActiveRecord::Migration[7.1]
  def change
    create_table :bookmarks do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.references :plan, foreign_key: true
      t.timestamps
    end
    add_index :bookmarks, [:user_id, :plan_id], unique: true
  end
end
