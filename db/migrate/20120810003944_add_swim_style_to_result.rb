class AddSwimStyleToResult < ActiveRecord::Migration
  def change
  	add_column :results, :swim_style_id, :integer
  end
end
