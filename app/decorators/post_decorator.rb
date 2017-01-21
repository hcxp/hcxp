class PostDecorator < Draper::Decorator
  delegate_all

  def public_html_path
    h.post_path(model)
  end

  def created_or_occured_at
    model.occured_at || model.created_at
  end

  def created_or_occured_at_caption
    parts = []
    parts << "#{h.t('activerecord.attributes.post.created_at')} #{model.created_at}"
    parts << "#{h.t('activerecord.attributes.post.occured_at')} #{model.occured_at}" if model.occured_at.present?

    parts.join(' / ')
  end
end
