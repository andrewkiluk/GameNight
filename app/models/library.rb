class Library < ActiveRecord::Base
  require Status

  has_many :library_games
  belongs_to :user
end
