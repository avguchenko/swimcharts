class AddSwimStyleToEvent < ActiveRecord::Migration
  def change
  	add_column :events, :swim_style_id, :integer
  end
end
