class User < ActiveRecord::Base
  include Status

  has_many :invitations
  has_many :events, through: :invitations
  has_many :hosted_events, source: :events
  has_many :relations
  has_one :library

  def to_s
    "User: id=#{id}, name=#{name}, email=#{email}"
  end


end
