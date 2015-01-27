class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, index: true
      t.references :movie, index: true
      t.boolean :positive

      t.timestamps null: false
    end
    add_foreign_key :votes, :users
    add_foreign_key :votes, :movies
    add_index :votes, [:user_id, :movie_id], unique: true
  end
end
