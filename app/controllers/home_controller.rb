class HomeController < ApplicationController
    
    def index
        @location = Location.auto_search
        @location_weather = Location.location_name 
        render json: { location: @location, location_weather: @location_weather }
    end
end 