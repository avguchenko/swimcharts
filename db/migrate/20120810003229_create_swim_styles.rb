class CreateSwimStyles < ActiveRecord::Migration
  def change
    create_table :swim_styles do |t|
      t.integer :distance
      t.integer :relay_count
      t.string :stroke

      t.timestamps
    end
  end
end
