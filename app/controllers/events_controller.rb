class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :update_action, :delete]


  # GET /events
  def index
    @upcoming_events = @current_user.get_upcoming_events
    @past_events = @current_user.get_past_events
  end

  # GET /events/1
  def show
    @attendees = @event.get_attending_users
    @games = @event.get_available_games
    @invitation = Invitation.find_by_event(@event.id, @current_user)
  end

  def respond
    event_id = params[:id]
    response = params[:response]
    if Invitation.respond_to_event(event_id, response, @current_user)
      if response == Status::ACCEPTED
        flash[:success] = "Invitation accepted!"
      elsif response == Status::PENDING
        flash[:success] = "Invitation rejected."
      end
    end
    render text: 'success'
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
      flash['error'] = 'There was a problem creating this event.'
      redirect_to :new
    end
  end


  def update

    unless allowed_to_update
      redirect_to :events
    end

    @friends = @current_user.get_friends
    @invited_friends = @event.get_invited_users
  end


  # POST /events/1
  def update_action

    unless allowed_to_update
      redirect_to :events
    end

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
      flash['error'] = 'There was a problem updating this event.'
      redirect_to @event
    end
  end

  # DELETE /events/1
  def delete
    @event.cancel
    flash['success'] = 'Event was successfully deleted.'
    render text: 'success'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Make sure that a user owns an event for them to make changes
    def allowed_to_update
      @event.host == @current_user
    end

end
