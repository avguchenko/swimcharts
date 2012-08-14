require 'digest/md5'
require 'Time'

class Meet < ActiveRecord::Base

	has_many :sessions
	has_many :events
	has_many :results

	belongs_to :imported_file

	OMEGA_ROOT = 'http://www.omegatiming.com/Sport?sport=AQ'
	YEARS = ['2007','2008','2009','2010','2011','2012']
	RESULT_FILE_PATH = File.join("C:","Sites", "swimcharts", "public","result_files")

	def Meet.get_omega_results

		ActiveRecord::Base.logger.level = 1
		ActiveRecord::Base.connection.execute("PRAGMA default_synchronous=OFF;")
		ActiveRecord::Base.connection.execute("PRAGMA count_changes=OFF;")
		ActiveRecord::Base.connection.execute("PRAGMA cache_size=10000;")
		ActiveRecord::Base.connection.execute("PRAGMA journal_mode=OFF;")

		time_re = /(?<h>\d\d):(?<m>\d\d):(?<s>\d\d).(?<ds>\d\d)$/
		urls = []
		agent = Mechanize.new
		agent.pluggable_parser.default = Mechanize::Download
		
		for year in YEARS
			print "\n\n\n\n#{year}\n\n\n\n"
			year_page = agent.get(OMEGA_ROOT+'&year='+year)

			print "got #{year_page.title}\n"
			
			for meet in year_page.links_with(:text => 'SWIMMING ')
				meet_page = agent.click(meet)
				

				for xml_link in meet_page.links_with(:text=>'Results in XML format')
					
					id = xml_link.href.match(/File\/Download\?id=(?<id>.*?)$/)[:id]
					print "\ndigesting...   "
					md5 = Digest::MD5.hexdigest(OMEGA_ROOT + xml_link.href)
					print "#{md5}\n"

					xml_doc = agent.click(xml_link)

					f = ImportedFile.find_by_md5(md5)

					if f == nil and !xml_doc.filename[".pdf"]
ImportedFile.transaction do
						#create new
						file = ImportedFile.new()
							file.file_id = id
							file.md5     = md5
							file.url     = xml_link.href
						
						#download
						file_path = File.join(RESULT_FILE_PATH, "Omega", "#{id}_#{xml_doc.filename}")
						xml_doc.save(file_path)
						
						#parse
						xml_doc = Nokogiri::XML(File.open(file_path))
						xml_doc.css("MEET").each do |meet|
							print "parsing #{meet_page.title}\n  "
							m        = Meet.find_or_create_by_md5(md5)
							m.name   = meet_page.title
							m.year   = year
							m.city   = meet[:city]
							m.nation = meet[:nation]
							m.course = meet[:course]
							m.timing = meet[:timing]
							m.save!

							file.meet_id = m.id
							file.save!

							
							meet.css("SESSION").each do |session|
								s = Session.find_or_create_by_meet_id_and_number(m.id, session[:number])
									print "S"
									s.meet         = m
									s.number       = session[:number]
									s.session_date = session[:date]
									s.daytime      = session[:daytime]
								s.save!

								session.css("EVENT").each do |event|
									e = Event.find_or_create_by_session_id_and_eventid(s.id, event[:eventid])
										print "e"
										e.meet         = m
										e.session      = s
										e.eventid      = event[:eventid].to_i
										e.event_number = event[:number].to_i
										e.prevevent_id = event[:preveventid].to_i
										e.gender       = event[:gender]
										e.round        = event[:round]
										e.daytime      = event[:daytime]
										e.order        = event[:order]

										event.css("SWIMSTYLE").each do |swim_style|
											ss = SwimStyle.find_or_create_by_distance_and_relay_count_and_stroke(swim_style[:distance], swim_style[:relaycount], swim_style[:stroke])
												print "!"
												ss.distance    = swim_style[:distance].to_i
												ss.relay_count = swim_style[:relaycount].to_i
												ss.stroke      = swim_style[:stroke]
											ss.save!
											e.swim_style   = ss	
										end #swim_style
									e.save!
								end #event
							end #session

							meet.css("CLUB").each do |club|
								c = Club.find_or_create_by_name(club[:name])
								print "C"
									c.name       = club[:name]
									c.short_name = club[:shortname]
									c.code       = club[:code]
									c.nation     = club[:nation]
									c.club_type  = club[:type]
								c.save!

								club.css("ATHLETE").each do |athlete|
									a = Athlete.find_or_create_by_first_name_and_last_name_and_birth_date(athlete[:firstname],athlete[:lastname],athlete[:birthdate])
										print "a"
										a.athleteid  = athlete[:athleteid]
										a.last_name  = athlete[:lastname]
										a.first_name = athlete[:firstname]
										a.gender     = athlete[:gender]
										a.birth_date = athlete[:birthdate]
									a.save!

									ce = CompetitorEntry.find_or_create_by_meet_id_and_athlete_id(m.id,a.id)
										ce.meet      = m
										ce.athlete   = a
										ce.athleteid = a.athleteid
									ce.save!

									athlete.css("RESULT").each do |result|
										r = Result.find_or_create_by_meet_id_and_athlete_id_and_eventid(m.id, a.id, result[:eventid])
										print "."
											r.athlete      = a
											r.club         = c
											r.meet         = m
											r.event        = Event.find_by_meet_id_and_eventid(m.id, result[:eventid])
											r.swim_style   = r.event.swim_style
											r.eventid      = result[:eventid]
											r.place        = result[:place]
											r.swimtime     = result[:swimtime]
											r.points       = result[:points]
											r.reactiontime = (result[:reactiontime].to_f)/100

											match = r.swimtime.match(time_re)
											if match
												r.swimtime_hours   = match[:h].to_f
												r.swimtime_minutes = match[:m].to_f
												r.swimtime_seconds = (match[:s]+'.'+match[:ds]).to_f
											else
												#print "\nswim_time = #{result[:swimtime]}\n"
											end
										r.save!

										result.css("SPLIT").each do |split|
											sp = Split.find_or_create_by_result_id_and_distance(r.id, split[:distance])
											print '\''
												sp.result   = r
												sp.swimtime = split[:swimtime]
												sp.distance = split[:distance]

												match = sp.swimtime.match(time_re)
												if match
													sp.swimtime_hours   = match[:h].to_f
													sp.swimtime_minutes = match[:m].to_f
													sp.swimtime_seconds = (match[:s]+'.'+match[:ds]).to_f
												else
													#print "\nsplit swim_time = #{split[:swimtime]}\n"
												end											
											sp.save!
										end #split

									end #result

								end #athlete

							end #club

						end #meet
print "\ncommitting transaction...\n"
end #transaction
					end #process new file

				end #xml_link

			end


		end

		return false

	end


	def Meet.run_etl

		
			


				#print session
				#print "\n\n"
				#gets
			



	end

end
