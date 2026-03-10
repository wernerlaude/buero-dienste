class CreateTags < ActiveRecord::Migration[8.0]
  def change
    create_table "tags", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
      t.datetime "created_at", precision: nil, null: false
      t.string "name"
      t.datetime "updated_at", precision: nil, null: false
      t.string "verweis"
    end
  end
end
