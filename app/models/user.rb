class User < ActiveRecord::Base
  include Status

  has_many :events, :through :invitations
  has_many :relations
  has_one :library

  attr_reader :id
  attr_accessor :name
  attr_accessor :email
  attr_accessor :hashed_password

end
