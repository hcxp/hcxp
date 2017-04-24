class EventWizardController < ApplicationController
  # steps :dates, :venue, :bands, :poster, :settings
  before_action :find_event
  before_action :set_steps

  helper_method :current_step

  STEPS = %w(dates venue bands poster settings ownership publish).freeze

  def show
    redirect_to step_event_wizard_path(@event, :dates)
  end

  def step
    if STEPS.include? params[:step]
      set_step_sessions
      self.send(params[:step].to_sym)
    end
  end

  def update
    if @event.update_attributes(event_params)
      redirect_to step_event_wizard_path(@event, next_step)
    else
      self.send(recent_step)
    end
  end

  def dates
    render :dates
  end

  def venue
    render :venue
  end

  def bands
    render :bands
  end

  def poster
    render :poster
  end

  def settings
    render :settings
  end

  def ownership
    render :ownership
  end

  def publish
    render :publish
  end

  def do_publish
    if @event.update_attributes(status: :published)
      redirect_to @event
    else
      render :publish, notice: 'Event published successfully'
    end
  end

  private

  def find_event
    @event = Event.find(params[:id]).decorate
  end

  def set_steps
    @steps = STEPS
  end

  def set_step_sessions
    session[:event_wizard_id]   = params[:id]
    session[:event_wizard_step] = params[:step]
  end

  def event_params
    params.require(:event).permit(
      :beginning_at, :venue_id, :poster, :remote_poster_url, :remove_poster,
      :link, :price, :name, :ownership_type,
      bandables_attributes: [:id, :band_id, :_destroy]
    )
  end

  def next_step
    next_idx = STEPS.find_index(session[:event_wizard_step]) + 1
    STEPS[next_idx]
  end

  def recent_step
    session[:event_wizard_step]
  end

  def current_step
    session[:event_wizard_step]
  end
end