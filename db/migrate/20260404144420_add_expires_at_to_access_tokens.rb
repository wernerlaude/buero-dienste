class AddExpiresAtToAccessTokens < ActiveRecord::Migration[8.1]
  def change
    add_column :access_tokens, :expires_at, :datetime
  end
end
