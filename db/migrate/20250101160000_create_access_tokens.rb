class CreateAccessTokens < ActiveRecord::Migration[8.0]
  def change
    create_table :access_tokens do |t|
      t.bigint :user_id, null: false
      t.string :token

      t.timestamps
    end

    add_index :access_tokens, :token, unique: true
    add_index :access_tokens, :user_id
  end
end
