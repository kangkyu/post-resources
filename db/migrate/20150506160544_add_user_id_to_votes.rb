class AddUserIdToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :user_id, 'Integer'
    add_index :votes, [:votable_id, :user_id], unique: false
  end
end
