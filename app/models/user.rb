class User < ActiveRecord::Base
  include Status

  has_many :events, :through :invitations
  has_many :relations
  has_one :library
end
