class RequestInfoBroadcastJob < ApplicationJob
  queue_as :default

  def perform(user, data)
    ScenesChannel.broadcast_to(
      Scene.find(data['id']),
      {
        info_type: data['info_type'],
        user_id: user.id
      }
    )
  end
end
