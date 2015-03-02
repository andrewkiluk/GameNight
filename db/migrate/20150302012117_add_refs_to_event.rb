class AddRefsToEvent < ActiveRecord::Migration
  def change
    add_reference :events, :host, references: :users, index: true
  end
end
