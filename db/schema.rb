# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120813230143) do

  create_table "athletes", :force => true do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "gender"
    t.string   "birth_date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "athleteid"
  end

  add_index "athletes", ["first_name"], :name => "index_athletes_on_first_name"
  add_index "athletes", ["gender"], :name => "index_athletes_on_gender"
  add_index "athletes", ["last_name"], :name => "index_athletes_on_last_name"

  create_table "clubs", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "code"
    t.string   "nation"
    t.string   "club_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "clubs", ["name"], :name => "index_clubs_on_name"
  add_index "clubs", ["nation"], :name => "index_clubs_on_nation"

  create_table "competitor_entries", :force => true do |t|
    t.integer  "meet_id"
    t.integer  "athlete_id"
    t.integer  "athleteid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.integer  "meet_id"
    t.integer  "session_id"
    t.integer  "eventid"
    t.integer  "event_number"
    t.integer  "prevevent_id"
    t.string   "gender"
    t.string   "round"
    t.string   "daytime"
    t.integer  "order"
    t.integer  "distance"
    t.integer  "relay_count"
    t.string   "stroke"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "swim_style_id"
  end

  create_table "imported_files", :force => true do |t|
    t.string   "file_id"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "md5"
    t.integer  "meet_id"
  end

  create_table "meets", :force => true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "nation"
    t.string   "course"
    t.string   "timing"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "year"
    t.string   "md5"
  end

  create_table "results", :force => true do |t|
    t.integer  "athlete_id"
    t.integer  "club_id"
    t.integer  "meet_id"
    t.integer  "session_id"
    t.integer  "event_id"
    t.integer  "eventid"
    t.integer  "place"
    t.string   "swimtime"
    t.integer  "points"
    t.float    "reactiontime"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.float    "swimtime_hours"
    t.float    "swimtime_minutes"
    t.float    "swimtime_seconds"
    t.integer  "swim_style_id"
  end

  add_index "results", ["athlete_id"], :name => "index_results_on_athlete_id"
  add_index "results", ["club_id"], :name => "index_results_on_club_id"
  add_index "results", ["event_id"], :name => "index_results_on_event_id"
  add_index "results", ["swim_style_id"], :name => "index_results_on_swim_style_id"

  create_table "sessions", :force => true do |t|
    t.integer  "meet_id"
    t.integer  "number"
    t.datetime "session_date"
    t.string   "daytime"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "splits", :force => true do |t|
    t.integer  "result_id"
    t.string   "swimtime"
    t.integer  "distance"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.float    "swimtime_hours"
    t.float    "swimtime_minutes"
    t.float    "swimtime_seconds"
  end

  add_index "splits", ["result_id"], :name => "index_splits_on_result_id"

  create_table "swim_styles", :force => true do |t|
    t.integer  "distance"
    t.integer  "relay_count"
    t.string   "stroke"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
