class CreateOffers < ActiveRecord::Migration[8.0]
  def change
    create_table :offers do |t|
      t.integer :category
      t.boolean :online
      t.integer :position
      t.string :ident, null: false
      t.string :slug
      t.string :card_image
      t.string :card_title, null: false
      t.string :image
      t.string :meta_desc
      t.string :header_title
      t.string :header_subtitle
      t.string :title
      t.string :subtitle
      t.text :short_desc
      t.text :description
      t.text :keywords
      t.integer :search_priority, default: 1
      t.integer :count

      t.timestamps
    end

    add_index :offers, :search_priority
  end
end