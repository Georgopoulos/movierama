class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.integer :likes, default: 0
      t.integer :hates, default: 0
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :movies, :users
    add_index :movies, [:user_id, :likes]
  end
end
