class Event < ActiveRecord::Base
  include Status
  include Utility

  belongs_to :host, class_name: "User"
  has_many :game_events
  has_many :games, through: :game_events
  has_many :game_event_votes
  has_many :invitations
  has_many :users, through: :invitations

  def modify(event_hash)
    self.start_time = Utility.to_active_record(event_hash[:datetime])
    self.place = event_hash[:place]
    self.description = event_hash[:description]

    invited_users = User
                      .joins("INNER JOIN invitations inv ON inv.user_id = users.id")
                      .joins("INNER JOIN events e ON inv.event_id = e.id")
                      .where("e.id = ?", self.id)
                      .all

    event_hash[:friend_invite_ids].each do |friend_id|
      friend = User.find(friend_id)
      unless friend.in?(invited_users)
        Invitation.create(event: self, user:friend, status: Status::PENDING)
      end
    end

  end

end
