class Relation < ActiveRecord::Base
  include Status

  belongs_to :user, class_name: "User"
  belongs_to :related_user, class_name: "User"

  has_one :inverse, class_name: "Relation", foreign_key: "inverse_id"
  belongs_to :relation, class_name: "Relation", foreign_key: "inverse_id"

  def self.find_friend_request_from(current_user, id)
    query_string = "user_id = ? AND related_user_id = ? AND status = ?"
    Relation.where(query_string, id, current_user.id, Status::PENDING).first
  end


  def self.delete_friend(current_user, id)
    relation = Relation.where("user_id = ? AND related_user_id = ?", current_user.id, id).first
    status = relation ? relation.status : Status::NULL

    if relation
      inverse = relation.inverse
      relation.destroy if relation
      inverse.destroy if inverse
    end

    status
  end


  def confirm_request(id)
    friendship_confirmation = Relation.create(
      user_id: self.related_user.id,
      related_user_id: id,
      status: Status::ACTIVE,
      inverse: self)

    self.status = Status::ACTIVE
    self.inverse = friendship_confirmation;
    self.save
  end

end
