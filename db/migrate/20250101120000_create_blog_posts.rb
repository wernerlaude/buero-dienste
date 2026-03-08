class CreateBlogPosts < ActiveRecord::Migration[8.0]
  def change
    create_table :blog_posts do |t|
      t.integer :user_id
      t.boolean :online
      t.string :list_title
      t.string :title
      t.string :subtitle
      t.string :meta_title
      t.string :meta_desc
      t.text :teaser
      t.text :content
      t.integer :lesezeit, default: 1
      t.string :bildnachweis
      t.string :verweis
      t.integer :count
      t.integer :ratings_count

      t.timestamps
    end
  end
end