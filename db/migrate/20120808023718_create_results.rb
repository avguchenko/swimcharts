class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :athlete_id
      t.integer :club_id
      t.integer :meet_id
      t.integer :session_id
      t.integer :event_id #for ORM
      t.integer :eventid #original data from XML
      t.integer :place
      t.datetime :swimtime
      t.integer :points
      t.float :reactiontime

      t.timestamps
    end
  end
end
