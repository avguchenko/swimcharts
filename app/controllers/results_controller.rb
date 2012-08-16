class ResultsController < ApplicationController
  

  def index
  	@quick_count = Result.find_by_sql("select count(*) as c from results").first.c
  end




  def splits
  	@splits = Result.find(params[:id]).splits
  	render :layout=>false
  end










end