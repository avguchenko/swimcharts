class CreateCompetitorEntries < ActiveRecord::Migration
  def change
    create_table :competitor_entries do |t|
      t.integer :meet_id
      t.integer :athlete_id
      t.integer :athleteid

      t.timestamps
    end
  end
end
