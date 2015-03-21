class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :delete]


  # GET /events
  def index
    @upcoming_events = Event
                        .joins('INNER JOIN invitations inv on inv.event_id = events.id')
                        .joins('INNER JOIN users u on inv.user_id = u.id')
                        .where('u.id = ?', @current_user.id)
                        .where('inv.status != ?', Status::REJECTED)
                        .first(500)
  end

  # GET /events/1
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # POST /events
  def new_action
    @event = Event.new(event_params)

    if @event.save
      flash['success'] = 'Event was successfully created.'
      redirect_to @event
    else
      render :new
      end
  end


  def update

  end


  # POST /events/1
  def update_action
    if @event.update(event_params)
      flash['success'] = 'Event was successfully updated.'
      redirect_to @event
    else
      render :update_form
    end
  end

  # DELETE /events/1
  def destroy
    @event.delete
    flash['success'] = 'Event was successfully deleted.'
    redirect_to :events
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params[:event]
    end
end
