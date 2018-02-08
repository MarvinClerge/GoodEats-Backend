require 'net/http'
require 'open-uri'
require 'json'

class Api::V1::PlacesController < ApplicationController
  def get_places
    base_url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'

    key = '?key=AIzaSyB49_gdZLhh1aovYeIFv9c8CS7Xt-Wxg4M'
    type = "&type=#{params[:type]}"
    radius = "&radius=#{params[:radius]}"
    location = '&location=40.7052569,-74.0162643'

    final_url = "#{base_url + key + location + type + radius}"

    uri = URI.parse(final_url)
    response = Net::HTTP.get_response(uri)
    response.body
    result = JSON.parse(response.body)

    # print params

    render json: {locations: result}
  end

  def get_place
    url = 'https://maps.googleapis.com/maps/api/place/details/json'

    # key = params[:key]
    # placeId = params[:placeId]

    key = '?key=AIzaSyB49_gdZLhh1aovYeIFv9c8CS7Xt-Wxg4M'
    place_id = '&placeid=ChIJjUw7LxJawokRByGsMS3I1Xc'

    final_url = "#{url + key + place_id}"


    uri = URI.parse(final_url)
    response = Net::HTTP.get_response(uri)
    response.body
    result = JSON.parse(response.body)

    render json: {locations: result, path: final_url}
  end


end
