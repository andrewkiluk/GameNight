class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      t.integer :status

      t.timestamps null: false
    end
  end
end
