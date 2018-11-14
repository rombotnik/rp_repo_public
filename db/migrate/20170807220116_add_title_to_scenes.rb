class AddTitleToScenes < ActiveRecord::Migration[5.1]
  def change
    add_column :scenes, :title, :string
  end
end
