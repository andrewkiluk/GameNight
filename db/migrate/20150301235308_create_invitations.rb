class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :status

      t.timestamps null: false
    end
  end
end
