class ScraperController < ApplicationController
  
  def index
    #if given param of metacafe, do this
    if params[:vendor] == "metacafe"
      
      #now with the video_id param, run the appropriate screen scraper
      text = Scraper.metacafe(params[:video_id])
      
      #render results on-screen
      render :text => text
    end
  end
  
end
