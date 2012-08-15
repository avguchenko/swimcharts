class Addwikiurltonations < ActiveRecord::Migration
  def up
  	add_column :nations, :wiki_url, :string
  end

  def down
  end
end
