class PostBroadcastJob < ApplicationJob
  queue_as :default

  def perform(user, data)
    is_new = data['post_id'].blank?

    if is_new
      post = user.posts.create!(body: data['post'], scene_id: data['id'])
    else
      post = Post.find(data['post_id'])
      post.update(body: data['post'], scene_id: data['id'])
    end

    ScenesChannel.broadcast_to(
      post.scene,
      {
        post: render_post(post, is_new),
        post_id: data['post_id'],
        is_new: is_new,
        user_id: user.id
      }
    )
  end

  private

  def render_post(post, is_new)
    PostsController.render partial: 'posts/post', locals: { post: post, include_wrapper: is_new}
  end
end
