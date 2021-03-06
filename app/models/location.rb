class Location < ApplicationRecord
    belongs_to :user

    def self.search_location(location_query)
        results = Geocoder.search(location_query)
        if  results === []
            begin
              raise Error
              rescue Error => e
                puts e.message
              end
              return
         end 
        response = results.first.coordinates  
        lat = response[0]
        lon = response[1]
        self.search(lat, lon)  
    end 

    def self.location_query(location_query)
        results = Geocoder.search(location_query)
        response = results[0]
    end
     
    
    def self.search(lat, lon)
        response = HTTParty.get("https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{lon}&exclude=minutely&appid=#{ENV['API_KEY']}&units=metric")
        data = JSON.parse(response.body) 
    end 
    
    def self.auto_search
        lat = self.lat
        lon = self.lon
        self.search(lat, lon) 
    end 
 
    def self.location_name
        results = Geocoder.search(ip)   
    end 

    def self.lat
        response = HTTParty.get("https://freegeoip.app/json/")
        ip = JSON.parse(response.body)
        lat = ip["latitude"]
    end 
     
    def self.lon
        response = HTTParty.get("https://freegeoip.app/json/")
        ip = JSON.parse(response.body)
        lon = ip["longitude"]
    end  
    
    def self.ip
        url = URI("https://freegeoip.app/json/")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Get.new(url)   
        request["accept"] = 'application/json'
        request["content-type"] = 'application/json'
        response = http.request(request)
        data = JSON.parse(response.body, symbolize_names: true)
        ip = data.fetch(:ip)
    end 

    def message
        puts "Sorry location not found" 
    end
end
