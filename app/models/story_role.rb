# == Schema Information
#
# Table name: story_roles
#
#  id           :integer          not null, primary key
#  character_id :integer
#  story_id     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_story_roles_on_character_id  (character_id)
#  index_story_roles_on_story_id      (story_id)
#
# Foreign Keys
#
#  fk_rails_...  (character_id => characters.id)
#  fk_rails_...  (story_id => stories.id)
#

class StoryRole < ApplicationRecord
  belongs_to :character
  belongs_to :story
end
