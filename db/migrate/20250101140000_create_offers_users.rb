class CreateOffersUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :offers_users, id: false do |t|
      t.bigint :offer_id
      t.bigint :user_id
    end

    add_index :offers_users, :offer_id
    add_index :offers_users, :user_id
  end
end
