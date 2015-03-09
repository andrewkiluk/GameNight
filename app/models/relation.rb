class Relation < ActiveRecord::Base
  include Status

  has_one :user, class_name: "User"
  has_one :related_user, class_name: "User"
  has_one :inverse, class_name: "Relation"
end
