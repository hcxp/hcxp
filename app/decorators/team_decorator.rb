class TeamDecorator < Draper::Decorator
  delegate_all

  def to_s
    model.name
  end

  # def avatar_url(w = 50, h = 50)
  #   gravatar_id = Digest::MD5.hexdigest(to_s).downcase
  #   "//gravatar.com/avatar/#{gravatar_id}.png?s=#{w}&d=mm"
  # end

  def avatar_url(width = 100, height = 100, opts = {})
    if model.avatar.file.present?
      opts = {
        width:  width,
        height: height,
        fit_in: opts[:fit_in]
      }
      opts.merge!(filters: ['no_upscale()'])
      h.thumbor_url(model.avatar.url, opts)
    else
      "https://placehold.it/#{width}x#{height}?text=#{opts[:text]}"
    end
  end

  def public_html_path
    h.team_path(model)
  end
end
