class AddFulltextIndexToOffers < ActiveRecord::Migration[8.0]
  def change
    execute "ALTER TABLE offers ADD FULLTEXT INDEX fulltext_keywords (keywords)"
  end
end