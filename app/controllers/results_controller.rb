class ResultsController < ApplicationController
  

  def index
  	@results = Result.find(:all)
  end



  def splits
  	@splits = Result.find(params[:id]).splits
  end










end