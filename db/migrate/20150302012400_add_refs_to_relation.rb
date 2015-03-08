class AddRefsToRelation < ActiveRecord::Migration
  def change
    add_reference :relations, :user, references: :users, index: true
    add_reference :relations, :related_user, references: :users, index: true
    add_reference :relations, :inverse, references: :relations, index: true
  end
end
