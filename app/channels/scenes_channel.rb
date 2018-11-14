class ScenesChannel < ApplicationCable::Channel
  def subscribed
    scene = Scene.find(params[:id])
    stream_for scene
  end

  def unsubscribed
    send_typing_state(
      {
        'id' => params[:id],
        'typing_state' => 'blank'
      }
    )
  end

  def send_post(data)
    PostBroadcastJob.perform_later(current_user, data)
  end

  def delete_post(data)
    DeletePostBroadcastJob.perform_later(data)
  end

  def send_typing_state(data)
    TypingStateBroadcastJob.perform_later(current_user, data)
  end

  def request_info(data)
    RequestInfoBroadcastJob.perform_later(current_user, data)
  end
end
