class Event < ActiveRecord::Base

	belongs_to :session
	belongs_to :meet
	belongs_to :swim_style

	has_many :results
	
end
