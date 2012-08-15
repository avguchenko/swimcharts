class AddIndexes < ActiveRecord::Migration
  def up

    remove_index :splits, :result_id
    remove_index :athletes, :last_name
    remove_index :athletes, :first_name
    remove_index :athletes, :gender
    remove_index :clubs, :nation
    remove_index :clubs, :name
    remove_index :results, :athlete_id
    remove_index :results, :event_id
    remove_index :results, :swim_style_id
    remove_index :results, :club_id

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
