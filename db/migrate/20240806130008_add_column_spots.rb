class AddColumnSpots < ActiveRecord::Migration[7.1]
  def change
    add_column :spots, :opening_hours, :string
    add_column :spots, :phone_number, :string
    add_column :spots, :latitude, :float
    add_column :spots, :longitude, :float
  end
end
