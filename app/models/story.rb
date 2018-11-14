# == Schema Information
#
# Table name: stories
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  genre_id    :integer
#  archived    :boolean          default(FALSE)
#
# Indexes
#
#  index_stories_on_genre_id  (genre_id)
#
# Foreign Keys
#
#  fk_rails_...  (genre_id => genres.id)
#

class Story < ApplicationRecord
  has_many :scenes, dependent: :destroy
  has_many :story_roles, dependent: :destroy
  has_many :characters, through: :story_roles
  has_many :notes, dependent: :destroy
  has_many :posts, through: :scenes

  belongs_to :genre

  accepts_nested_attributes_for :story_roles, allow_destroy: true

  acts_as_taggable

  validates :title, presence: true, length: { maximum: 255 }
  validates :genre_id, presence: true

  def character_list
    characters.pluck(:name).join(', ')
  end

  def favorite?
    false
  end

  def to_s
    title
  end
end
