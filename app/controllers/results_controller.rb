class ResultsController < ApplicationController
  

  def index
  	@results = Result.find(:all)
  end














end