class Session < ActiveRecord::Base

	belongs_to :meet

	has_many :events
	has_many :results, :through=>:event
	
end
