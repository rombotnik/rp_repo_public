class CreateStoryRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :story_roles do |t|
      t.references :character, foreign_key: true
      t.references :story, foreign_key: true

      t.timestamps
    end
  end
end
