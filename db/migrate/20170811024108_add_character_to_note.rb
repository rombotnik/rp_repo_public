class AddCharacterToNote < ActiveRecord::Migration[5.1]
  def change
    add_reference :notes, :character, foreign_key: true
  end
end
