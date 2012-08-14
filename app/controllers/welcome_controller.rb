  	require 'nokogiri'

class WelcomeController < ApplicationController
  

  def index
  	#@athletes = Athlete.find(:all)
  	#@clubs = Club.find(:all)
  	#@events = Event.find(:all)
  	#@results = Result.find(:all)

  	#@meets = Meet.find(:all)
  	#@sessions = Session.find(:all)
  	#@splits = Split.find(:all)

  	#@swimmer = Athlete.find_by_last_name('Phelps')

  	swim_style = SwimStyle.find(10)

  

  	r = Result.hundred_free.select {|r| r.event.gender = 'M' and r.swim_style_id = 10 and r.swimtime!=0 and r.swimtime!='NT'}#.where(["swim_style_id = ? and swimtime<>? and swimtime<>?",swim_style.id,'NT', '0'], )
  			.group_by { |e| e.session_date }
  			.map { |k,v| [k,v.sort!{|q,f| q.to_seconds<=>f.to_seconds}.first] }.sort! {|x,y| x[0]<=>y[0]}

  	#r = Result.find(:all,
  	#				:include => [:event,:session],
  	#				:where=> :event[:gender]='M')


  	@results = r.map { |d,r| "[#{r.highchart_date}, #{r.swimtime_seconds}]" }
	#@results = r.map { |d,r| [escape_javascript(r.highchart_date), r.to_seconds] }
  	
#render :text=> "<pre>#{@results.to_yaml}</pre>"
  	
  

  	#.map { |r| "[#{r.highchart_date}, #{r.to_seconds}]" }.join(",")

  	@h = LazyHighCharts::HighChart.new('graph') do |f|
	  f.options[:chart][:defaultSeriesType] = "spline"
	  
	  f.xAxis(:type=>'date', :title=>{:text=>'Date'})
	  f.yAxis( :title=>{:text=>'Result'})


	  f.series(:name=>swim_style.to_s, :data=> @results)
	end
	return nil
  end




def get_files
	folder = File.join("C:", "Users", "Malia", "Downloads", "swimming results", "*.xml")#C:\Users\Malia\Downloads\swimming results
	return Dir.glob(folder)
end






end