class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :delete]


  # GET /events
  def index
    @invited_events = Event
                        .joins('INNER JOIN invitations inv on inv.event_id = events.id')
                        .joins('INNER JOIN users u on inv.user_id = u.id')
                        .where('u.id = ?', @current_user.id)
                        .where('inv.status != ?', Status::REJECTED)
                        .where('events.start_time > ?', Time.now)
                        .first(500)

    @hosted_events = Event.where(host: @current_user).where('events.start_time > ?', Time.now)
    @upcoming_events = @invited_events && @hosted_events
  end

  # GET /events/1
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
    @friends = @current_user.get_friends
    @invited_friends = []
  end

  # POST /events
  def new_action
    @event = Event.new(host: @current_user)

    event_hash = {
      datetime: params[:datetime],
      place: params[:place],
      description: params[:description],
      friend_invite_ids: params[:friend_invite_ids].split(',')
    }
    @event.modify(event_hash)

    if @event.save
      flash['success'] = 'Event was successfully created.'
      redirect_to @event
    else
      flash['success'] = 'There was a problem creating this event.'
      render :new
    end
  end


  def update
    event_hash = {
      datetime: params[:datetime],
      place: params[:place],
      description: params[:description],
      friend_invite_ids: params[:friend_invite_ids].split(',')
    }
    @event.modify(event_hash)

    if @event.save
      flash['success'] = 'Event was successfully updated.'
      redirect_to @event
    else
      flash['success'] = 'There was a problem updating this event.'
      render @event
    end

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

end
