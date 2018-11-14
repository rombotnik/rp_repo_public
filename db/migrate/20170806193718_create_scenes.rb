class CreateScenes < ActiveRecord::Migration[5.1]
  def change
    create_table :scenes do |t|
      t.references :story, foreign_key: true
      t.integer :order

      t.timestamps
    end
  end
end
