class Event < ActiveRecord::Base
  include Status

  belongs_to :host, class_name: "User"
  has_many :games, through: :game_events
  has_many :game_event_votes
  has_many :users, through: :invitations

  attr_accessor :description
  attr_accessor :name
  attr_accessor :place
  attr_accessor :start_time
end
