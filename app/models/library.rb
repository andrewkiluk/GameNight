class Library < ActiveRecord::Base
  include Status

  has_many :library_games
  belongs_to :user
end
