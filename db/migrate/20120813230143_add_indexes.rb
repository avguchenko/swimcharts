class AddIndexes < ActiveRecord::Migration
  def up

  	add_index :splits, :result_id
  	add_index :athletes, :last_name
  	add_index :athletes, :first_name
  	add_index :athletes, :gender
  	add_index :clubs, :nation
  	add_index :clubs, :name
  	add_index :results, :athlete_id
  	add_index :results, :event_id
  	add_index :results, :swim_style_id
  	add_index :results, :club_id

  end

  def down
  end
end
