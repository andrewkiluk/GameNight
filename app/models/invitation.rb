class Invitation < ActiveRecord::Base
  include Status

  belongs_to :user
  belongs_to :event

end
