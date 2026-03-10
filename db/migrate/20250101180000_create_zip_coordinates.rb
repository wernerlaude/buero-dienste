class CreateZipCoordinates < ActiveRecord::Migration[8.0]
  def change
    create_table :zip_coordinates do |t|
      t.string :loc_id
      t.string :plz
      t.string :ort
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
