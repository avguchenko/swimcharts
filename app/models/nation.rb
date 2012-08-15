class Nation < ActiveRecord::Base

	def flag_icon_png
		return "<img src='famfamfam_flag_icons/png/'#{self.fips_code}.png'>"
	end

	def flag_icon_gif
		return "<img src='famfamfam_flag_icons/gif/'#{self.fips_code}.png'>"
	end

end
