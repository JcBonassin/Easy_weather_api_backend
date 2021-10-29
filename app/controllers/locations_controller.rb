class LocationsController < ApplicationController

    def index    
        @locations = Location.all
        render json: @locations
      end

      def show
        @location = Location.search_location(params[:id])
        @location_weather = Location.location_query(params[:id])
        render json: { location: @location, location_weather: @location_weather }
      end

      def create
        #binding.pry
        @location = Location.create(location_params)

        if @location.save
          render json: @location
        else
          render json: @location.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @location = Location.find(params[:id])
        @location.destroy
      end

      private
    # Use callbacks to share common setup or constraints between actions.
   
    # Only allow a trusted parameter "white list" through.
    def location_params
      params.require(:location).permit(:name, :user_id)
    end
end
