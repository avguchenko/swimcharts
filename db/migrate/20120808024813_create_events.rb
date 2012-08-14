class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :meet_id
      t.integer :session_id
      t.integer :eventid
      t.integer :event_number
      t.integer :prevevent_id
      t.string :gender
      t.string :round
      t.string :daytime
      t.integer :order
      t.integer :distance
      t.integer :relay_count
      t.string :stroke

      t.timestamps
    end
  end
end
