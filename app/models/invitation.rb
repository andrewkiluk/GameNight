class Invitation < ActiveRecord::Base
  include Status

  belongs_to :user
  belongs_to :event

  def self.respond_to_event(event_id, response, current_user)
    invitation = Invitation.find_by_event(event_id, current_user)
    if response.to_i == Status::ACCEPTED
      invitation.accept
    elsif response.to_i == Status::REJECTED
      invitation.reject
    else
    end
  end

  def self.find_by_event(event_id, current_user)
    Invitation.find_by("event_id = ? AND user_id = ?", event_id, current_user.id)
  end

  def self.invite(event, user)
    Invitation.create(event: event, user: user, status: Status::PENDING)
  end

  def accept
    self.status = Status::ACCEPTED
    self.save
  end

  def reject
    self.status = Status::REJECTED
    self.save
  end

end
