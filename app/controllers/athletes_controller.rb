class AthletesController < ApplicationController
  helper_method :sort_column, :sort_direction 

  def index
  	if params[:search]
  		@athletes = Athlete.search(params[:search]).limit(50).order(sort_column + ' ' + sort_direction)
  		@quick_count = Athlete.find_by_sql(["SELECT count(*) as c from athletes where first_name like ? or last_name like ?","%#{params[:search]}%","%#{params[:search]}%"]).first.c
  		@densities = Athlete.select("count(*) as c, name").group("name")
  	else
  		@athletes = Athlete.limit(50).order(sort_column + ' ' + sort_direction)
  		@quick_count = Athlete.find_by_sql("SELECT count(*) as c from athletes").first.c

  	end
  end



  def show
  	@athlete = Athlete.find(params[:id])
  	@results = @athlete.results.includes(:swim_style, :meet, :session, :club)

  	if params[:swim_style]
  		@results = @athlete.results.where(:swim_style_id=>params[:swim_style]).includes(:swim_style, :meet, :session, :club)
  	end
  	@swim_styles = @results.map {|r| r.swim_style}.uniq
  end

  def quick_count

  end

  def typeahead
  	@athletes = Athlete.find(:all).map {|a| a.name}.join(",")
  end


private  
  def sort_column  
    Athlete.column_names.include?(params[:sort]) ? params[:sort] : "last_name"
  end  
    
  def sort_direction  
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end  




end