# == Schema Information
#
# Table name: characters
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  gender     :string
#
# Indexes
#
#  index_characters_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Character < ApplicationRecord
  belongs_to :user

  has_many :story_roles, dependent: :destroy
  has_many :stories, through: :story_roles
  has_many :notes, dependent: :destroy

  default_scope { order :name }

  acts_as_taggable

  validates :name, presence: true, length: { maximum: 50 }
  validates :gender, presence: true

  GENDERS = [
    'Male',
    'Female',
    'Other'
  ]

  def to_s
    name
  end
end
