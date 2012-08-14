class CreateSplits < ActiveRecord::Migration
  def change
    create_table :splits do |t|
      t.integer :result_id
      t.datetime :swimtime
      t.integer :distance

      t.timestamps
    end
  end
end
