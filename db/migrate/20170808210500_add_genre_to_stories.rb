class AddGenreToStories < ActiveRecord::Migration[5.1]
  def change
    add_reference :stories, :genre, foreign_key: true
  end
end
