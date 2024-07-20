class CreateProfileImages < ActiveRecord::Migration[7.1]
  def change
    create_table :profile_images do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
