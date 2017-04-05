class LanguagePickerCell < ApplicationCell
  def show
    render
  end

  private

  def languages
    {
      en: { emoji: '🇬🇧', t_key: 'english' },
      pl: { emoji: '🇵🇱', t_key: 'polish' },
      cs: { emoji: '🇨🇿', t_key: 'czech' },
    }
  end

  def language_label(key, lang)
    I18n.with_locale(key) { t(lang[:t_key]) }
  end

  def current_lang
    languages[I18n.locale.to_sym]
  end

end
