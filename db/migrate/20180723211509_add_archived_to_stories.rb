class AddArchivedToStories < ActiveRecord::Migration[5.1]
  def change
    add_column :stories, :archived, :boolean, default: false
  end
end
