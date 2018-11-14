class TypingStateBroadcastJob < ApplicationJob
  queue_as :default

  def perform(user, data)
    ScenesChannel.broadcast_to(
      Scene.find(data['id']),
      {
        typing_state: data['typing_state'],
        user_id: user.id,
        message: render_typing_state(user, data['typing_state'])
      }
    )
  end

  private

  def render_typing_state(user, typing_state)
    case typing_state
    when 'blank'
      ""
    when 'entered'
      "#{user.name} has entered text"
    when 'typing'
      "#{user.name} is typing ..."
    else
      ""
    end
  end
end
