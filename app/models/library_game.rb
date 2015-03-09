class LibraryGame < ActiveRecord::Base
  include Status

  belongs_to :library
  belongs_to :game
end
