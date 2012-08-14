class Athlete < ActiveRecord::Base
	has_many :results
	belongs_to :events
	
	scope :men, where(:gender=>"M")
	scope :women, where(:gender=>"F")

	scope :phelps, where("last_name like '%Phelps%'")

	def Athlete.order_preference
		"last_name, first_name ASC"
	end

	def name
		last_name.upcase + ' ' + first_name.capitalize
	end

	def self.search(search)
	    if search
	      where('last_name LIKE ? or first_name like ?', "%#{search}%","%#{search}%")
	    else
	      scoped
	    end
  	end

end
