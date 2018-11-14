# == Schema Information
#
# Table name: genres
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Genre < ApplicationRecord
  has_many :stories, dependent: :nullify

  default_scope { order :name }

  validates :name, presence: true

  def to_s
    name
  end
end
