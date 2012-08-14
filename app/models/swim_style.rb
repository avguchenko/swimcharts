class SwimStyle < ActiveRecord::Base

	has_many :events
	has_many :results

	def to_s
		if self.relay_count == 4
			r = ' Relay'
		else
			r = ''
		end
		return self.distance.to_s+' '+self.stroke+r
	end









end
