class AddRefsToUser < ActiveRecord::Migration
  def change
    add_reference :users, :library, references: :libraries, index: true
  end
end
