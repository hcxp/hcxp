class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def about; end

  def change_locale
    l = params[:locale].to_s.strip.to_sym
    l = I18n.default_locale unless I18n.available_locales.include?(l)
    cookies.permanent[:hcxp_locale] = l
    redirect_to request.referer || root_url
  end

  def check
    render text: 'OK'
  end

  private # --------------------------------------------------------------------

  # @todo  Move that to service
  #
  def events_index(col = Event.all)
    col = col.includes(:bands, :venue)
    col = col.search(params[:q]) if params[:q].present?


    case params[:s]
      when 'past'
        col = col.past.order(beginning_at: :desc)
      when 'all'
        col = col.order(beginning_at: :desc)
      else
        col = col.upcoming.order(beginning_at: :asc)
    end

    col = col.page(params[:page])

    col
  end

  # @todo  Move that to service
  #
  def bands_index(col = Band.all)
    col = col.search(params[:q]) if params[:q].present?
    col = col.where(id: params[:id_in]) if params[:id_in].present?
    col = col.order(events_count: :desc)
    col = col.page(params[:page])

    col
  end

  # @todo  Move that to service
  #
  def venues_index(col = Venue.all)
    col = col.search(params[:q]) if params[:q].present?
    col = col.page(params[:page])

    col
  end

  # @todo  move that to service
  #
  def teams_index(col = Team.all)
    col = col.page(params[:page])
  end

  # @todo  Move that to service
  #
  def posts_index(col = Post.all)
    col = col.includes(:bands, :user)
    col = col.search(params[:q]) if params[:q].present?
    col = col.page(params[:page])

    col
  end

  # Taken from https://www.sitepoint.com/go-global-rails-i18n/
  #
  def set_locale
    if cookies[:hcxp_locale] && I18n.available_locales.include?(cookies[:hcxp_locale].to_sym)
      l = cookies[:hcxp_locale].to_sym
    else
      # l = I18n.default_locale
      l = extract_locale_from_accept_language_header
      # cookies.permanent[:hcxp_locale] = l
    end
    I18n.locale = l
  end

  def extract_locale_from_accept_language_header
    locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first.to_sym

    if I18n.available_locales.include? locale
      logger.debug("Locale #{locale} found in available locales")
      locale
    else
      logger.debug("Locale #{locale} not found in available locales. Using default one")
      I18n.default_locale
    end
  rescue => e
    logger.debug("Something went wrong while extracting lang from headers: #{e.message}")
    I18n.default_locale
  end

  protected # ------------------------------------------------------------------

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
