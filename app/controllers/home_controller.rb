class HomeController < ApplicationController
  def index
  	require 'net/http'
  	require 'json'
  	@url = 'http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=20002&distance=0&API_KEY=5B2D49B0-C181-4810-9F0C-24E7584E6197'
  	@uri = URI(@url)
  	@response = Net::HTTP.get(@uri)
  	@output = JSON.parse(@response)
  	if @output.present?
  		@final_output = @output[0]['AQI']
  	elsif !@output
  		@final_output = "Error"
  	else
  		@final_output = "Something went wrong"
  	end

  	if @final_output.is_a? Numeric
  		if @final_output <= 50
  			@api_color = "green"
  		elsif @final_output >= 51 or @final_output <= 100
  			@api_color = "yellow"
  		elsif @final_output >= 101 or @final_output <= 150
  			@api_color = "orange"
  		elsif @final_output >= 151 or @final_output <= 200
  			@api_color = "red"
  		elsif @final_output >= 201 or @final_output <= 300
  			@api_color = "purple"
  		elsif @final_output >= 301 or @final_output <= 500
  			@api_color = "maroon"
  		end
  	else
  		@api_color = "silver"
  	end
  end
end
