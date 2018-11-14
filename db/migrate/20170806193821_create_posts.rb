class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.references :scene, foreign_key: true
      t.integer :order
      t.text :body
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
