class CreatePageViews < ActiveRecord::Migration[8.0]
  def change
    create_table :page_views do |t|
      t.string :page_name
      t.datetime :viewed_at

      t.timestamps
    end
  end
end