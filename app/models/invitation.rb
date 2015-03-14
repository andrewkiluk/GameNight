class Invitation < ActiveRecord::Base
  require Status

  belongs_to :user
  belongs_to :event

end
