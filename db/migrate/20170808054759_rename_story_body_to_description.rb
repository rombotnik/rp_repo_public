class RenameStoryBodyToDescription < ActiveRecord::Migration[5.1]
  def change
    rename_column :stories, :body, :description
  end
end
