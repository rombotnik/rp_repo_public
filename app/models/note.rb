# == Schema Information
#
# Table name: notes
#
#  id           :integer          not null, primary key
#  title        :string
#  body         :text
#  story_id     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  character_id :integer
#
# Indexes
#
#  index_notes_on_character_id  (character_id)
#  index_notes_on_story_id      (story_id)
#
# Foreign Keys
#
#  fk_rails_...  (character_id => characters.id)
#  fk_rails_...  (story_id => stories.id)
#

class Note < ApplicationRecord
  belongs_to :story, required: false
  belongs_to :character, required: false

  validates :title, presence: true
end
