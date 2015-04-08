class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :votable_type
      t.integer :votable_id
      t.boolean :voted

      t.timestamps
    end

    add_index :votes, [:votable_id, :votable_type], unique: true
  end
end
