class TeamDecorator < Draper::Decorator
  delegate_all

  def to_s
    model.name
  end

  def avatar_url(w = 50, h = 50)
    gravatar_id = Digest::MD5.hexdigest(to_s).downcase
    "//gravatar.com/avatar/#{gravatar_id}.png?s=#{w}&d=mm"
  end

  def public_html_path
    h.team_path(model)
  end
end
