class Club < ActiveRecord::Base

	has_many :athletes
	has_many :results

	
end
