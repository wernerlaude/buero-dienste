class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.integer :bundesland_id
      t.boolean :online, default: false, null: false
      t.boolean :premium, default: false, null: false
      t.boolean :datenschutz
      t.boolean :copyright
      t.boolean :maps, default: false
      t.boolean :erstberatung
      t.string :email, default: "", null: false
      t.string :anrede
      t.string :vorname
      t.string :nachname
      t.string :firmenname
      t.string :gesellschaftsform
      t.string :strasse
      t.string :plz
      t.string :ort
      t.string :telefon
      t.string :mobile
      t.string :webpage
      t.decimal :longitude, precision: 15, scale: 10
      t.decimal :latitude, precision: 15, scale: 10
      t.string :other_offers
      t.string :firmenmotto
      t.string :berufsbezeichnung
      t.string :qualifikation
      t.text :beschreibung
      t.string :meta_title
      t.string :meta_desc
      t.text :references
      t.date :vertragsbegin
      t.decimal :price, precision: 8, scale: 2
      t.integer :count, default: 0
      t.string :otp_secret
      t.datetime :booked_at

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end