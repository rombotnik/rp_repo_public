# == Schema Information
#
# Table name: scenes
#
#  id         :integer          not null, primary key
#  story_id   :integer
#  order      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#
# Indexes
#
#  index_scenes_on_story_id  (story_id)
#
# Foreign Keys
#
#  fk_rails_...  (story_id => stories.id)
#

class Scene < ApplicationRecord
  belongs_to :story, touch: true
  has_many :posts, dependent: :destroy

  validates :title, presence: true
  validates :order, presence: true, numericality: { greater_than: 0 }

  default_scope { order :order }

  acts_as_taggable

  def to_s
    title
  end
end
