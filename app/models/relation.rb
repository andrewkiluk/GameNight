class Relation < ActiveRecord::Base
  include Status

  has_one :user, class_name: "User"
  has_one :related_user, class_name: "User"

  attr_accessor :status
end
