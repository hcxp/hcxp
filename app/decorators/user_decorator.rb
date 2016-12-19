class UserDecorator < Draper::Decorator
  delegate_all

  def to_s
    model.username
  end

  def avatar_url(w = 50, h = 50)
    gravatar_id = Digest::MD5.hexdigest(user.email).downcase
    "//gravatar.com/avatar/#{gravatar_id}.png?s=#{w}&d=mm"
  end

  def public_html_path
    h.user_path(model.username)
  end
end
