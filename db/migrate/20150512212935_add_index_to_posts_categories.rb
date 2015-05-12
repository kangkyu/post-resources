class AddIndexToPostsCategories < ActiveRecord::Migration
  def change
    add_index :posts_categories, [:post_id, :category_id], unique: true
  end
end
