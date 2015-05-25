class User < ActiveRecord::Base
  include Status

  has_many :invitations
  has_many :events, through: :invitations
  has_many :hosted_events, source: :events
  has_many :relations
  belongs_to :library

  def self.search(search_string)
    search_fragment = "%" + search_string + "%"
    User.where("email LIKE ? OR name LIKE ?", search_fragment, search_fragment)
  end


  def self.make_new_user(name, email, hashed_password)
    library = Library.create()
    User.create(name: name, email: email, hashed_password: hashed_password, library: library)
  end


  def compare_collections(friend)

    all_my_games = Game.by_user(self)
    all_their_games = Game.by_user(friend)

    my_games = all_my_games - all_their_games
    our_games = all_my_games & all_their_games
    their_games = all_their_games - all_my_games

     return my_games, our_games, their_games
  end


  def get_friend_status(other_user)
    if self == other_user
      return Status::EQUAL
    end
    relation = Relation.where("user_id =? AND related_user_id = ?", self.id, other_user.id).first
    relation && relation.status
  end


  def get_friends
    User
      .joins("JOIN relations AS rel
              ON rel.user_id = users.id")
      .joins("JOIN relations AS inv
              ON rel.inverse_id = inv.id")
      .where("rel.related_user_id == ?", self.id)
      .where("rel.status == ?", Status::ACTIVE)
      .where("inv.status == ?", Status::ACTIVE)
      .order("users.name")
  end


  def get_past_events
    invited_events = Event
                        .joins('INNER JOIN invitations inv on inv.event_id = events.id')
                        .joins('INNER JOIN users u on inv.user_id = u.id')
                        .where('u.id = ?', self.id)
                        .where('inv.status != ?', Status::REJECTED)
                        .where('events.start_time <= ?', Time.now)
                        .first(500)

    hosted_events = Event.where(host: self).where('events.start_time <= ?', Time.now)
    invited_events | hosted_events
  end


  def get_upcoming_events
    invited_events = Event
                        .joins('INNER JOIN invitations inv on inv.event_id = events.id')
                        .joins('INNER JOIN users u on inv.user_id = u.id')
                        .where('u.id = ?', self.id)
                        .where('inv.status != ?', Status::REJECTED)
                        .where('events.start_time > ?', Time.now)
                        .first(500)

    hosted_events = Event.where(host: id).where('events.start_time > ?', Time.now)
    invited_events | hosted_events
  end


  def to_s
    "User: id=#{id}, name=#{name}, email=#{email}"
  end


end
