# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  scene_id   :integer
#  body       :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_posts_on_scene_id  (scene_id)
#  index_posts_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (scene_id => scenes.id)
#  fk_rails_...  (user_id => users.id)
#

class Post < ApplicationRecord
  belongs_to :scene, touch: true
  belongs_to :user
  has_one :story, through: :scene

  default_scope { order(created_at: :asc) }
end
