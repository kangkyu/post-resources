class SetupManyToMany < ActiveRecord::Migration
  def change
    create_table :posts_categories do |t|
      t.integer :post_id, :category_id
      t.timestamps
    end
    remove_column :categories, :post_id
  end
end
