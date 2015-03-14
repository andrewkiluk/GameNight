class LibraryGame < ActiveRecord::Base
  require Status

  belongs_to :library
  belongs_to :game
end
