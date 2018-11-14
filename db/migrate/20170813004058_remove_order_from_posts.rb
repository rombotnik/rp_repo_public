class RemoveOrderFromPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :order
  end
end
