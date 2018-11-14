class AddGenderToCharacters < ActiveRecord::Migration[5.1]
  def change
    add_column :characters, :gender, :string
  end
end
