class Result < ActiveRecord::Base

	belongs_to :athlete
	belongs_to :event
	belongs_to :club
	belongs_to :meet
	belongs_to :swim_style
	belongs_to :session
	has_many :splits

	scope :for_athlete, lambda { |athlete| where("athlete_id < ?", athlete.id) } 

	def hundred_free
		where("swim_style_id = ?", 10)
	end


	def to_seconds
		if self.swimtime and self.swimtime!='NT'
			s = self.swimtime_hours.to_f*3600+self.swimtime_minutes.to_f*60+self.swimtime_seconds.to_f
			if s == 0 
				return nil
			else
				return s
			end
		else 
			nil
		end
	end

	def highchart_date
		if self.event and self.event.session and self.event.session.session_date
	
			d = self.event.session.session_date
			m = d.strftime("%m").to_i-1
			return "Date.UTC(#{d.strftime('%Y')}, #{m}, #{d.strftime('%d')})"
		else
			nil
		end
	end

	def session_date
		if self.event and self.event.session and self.event.session.session_date

			d = self.event.session.session_date
			return d
		else
			nil
		end
	end









end
