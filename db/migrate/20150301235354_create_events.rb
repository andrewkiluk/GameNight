class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :start_time
      t.string :place
      t.string :description

      t.timestamps null: false
    end
  end
end
