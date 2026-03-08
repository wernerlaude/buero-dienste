class CreateLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :links do |t|
      t.boolean :online
      t.integer :position
      t.string :bezeichner
      t.string :target_url
      t.text :beschreibung

      t.timestamps
    end
  end
end
