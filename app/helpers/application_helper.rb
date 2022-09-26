module ApplicationHelper
  def render_turbo_stream_flash_messages
    turbo_stream.update 'flash', partial: 'layouts/flash'
  end

  # https://stackoverflow.com/questions/14361952/rails-gravatar-helper-method
  def avatar_url(user, size)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=retro"
  end
end
