class Event < ActiveRecord::Base
  include Status
  include Utility

  belongs_to :host, class_name: "User"
  has_many :game_events
  has_many :games, through: :game_events
  has_many :game_event_votes
  has_many :invitations
  has_many :users, through: :invitations

  def get_invited_users
    others = User
      .joins("INNER JOIN invitations inv ON inv.user_id = users.id")
      .joins("INNER JOIN events e ON inv.event_id = e.id")
      .where("e.id = ?", self.id)
      .first(500)
    others.push self.host
  end

  def get_attending_users
    others = User
      .joins("INNER JOIN invitations inv ON inv.user_id = users.id")
      .joins("INNER JOIN events e ON inv.event_id = e.id")
      .where("e.id = ?", self.id)
      .where("inv.status = ?", Status::ACCEPTED)
      .first(500)
    others.push self.host
  end

  def host
    User.find(self.host_id)
  end

  def get_available_games
    users = self.get_attending_users
    Game
      .joins("INNER JOIN library_games lg ON lg.game_id = games.id")
      .joins("INNER JOIN libraries lib ON lg.library_id = lib.id")
      .joins("INNER JOIN users u ON lib.id = u.library_id")
      .where("u.id in (?)", users)
  end

  def modify(event_hash)
    self.start_time = Utility.to_active_record(event_hash[:datetime])
    self.place = event_hash[:place]
    self.description = event_hash[:description]

    previously_invited_users = self.get_invited_users
    previously_invited_user_ids = previously_invited_users.map{|user| user.id}

    # Add newly invited users
    newly_invited_friend_ids = event_hash[:friend_invite_ids].map{ |id| id.to_i }
    newly_invited_friend_ids.each do |friend_id|
      friend = User.find(friend_id)
      unless friend.in?(previously_invited_users)
        Invitation.invite(self, friend)
      end
    end

    # Remove uninvited users
    reject_ids = previously_invited_user_ids - newly_invited_friend_ids
    reject_ids.each do |reject_id|
      friend = previously_invited_users.select{|user| user.id == reject_id}
      Invitation.destroy_all(event: self, user:friend)
    end
  end

  def cancel

    # TODO: Destroy related invitations

    self.destroy
  end


end
