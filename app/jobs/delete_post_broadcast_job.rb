class DeletePostBroadcastJob < ApplicationJob
  queue_as :default

  def perform(data)
    post = Post.find(data['post_id'])
    scene = post.scene

    post.destroy

    ScenesChannel.broadcast_to(
      scene,
      {
        post_id: data['post_id'],
        is_deleted: true
      }
    )
  end
end
