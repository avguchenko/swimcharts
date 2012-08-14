class AthletesController < ApplicationController
  helper_method :sort_column, :sort_direction 

  def index
  	

  	if params[:search]
  		@athletes = Athlete.search(params[:search]).limit(50).order(sort_column + ' ' + sort_direction)
  	else
  		@athletes = Athlete.limit(50).order(sort_column + ' ' + sort_direction)
  	end
  end



  def show
  	@athlete = Athlete.find(params[:id])
  	@results = @athlete.results.includes(:swim_style, :meet, :session)
  end





private  
  def sort_column  
    Athlete.column_names.include?(params[:sort]) ? params[:sort] : "last_name"
  end  
    
  def sort_direction  
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end  




end