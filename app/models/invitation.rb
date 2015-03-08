class Invitation < ActiveRecord::Base
  include Status

  attr_accessor :status
end
