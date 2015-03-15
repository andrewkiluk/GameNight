class Event < ActiveRecord::Base
  include Status

  belongs_to :host, class_name: "User"
  has_many :game_events
  has_many :games, through: :game_events
  has_many :game_event_votes
  has_many :invitations
  has_many :users, through: :invitations

end
