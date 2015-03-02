class AddRefsToInvitation < ActiveRecord::Migration
  def change
    add_reference :invitations, :event, references: :events, index: true
    add_reference :invitations, :user, references: :users, index: true
  end
end
