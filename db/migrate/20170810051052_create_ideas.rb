class CreateIdeas < ActiveRecord::Migration[5.1]
  def change
    create_table :ideas do |t|
      t.text :body
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
