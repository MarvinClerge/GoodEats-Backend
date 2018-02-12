require 'net/http'
require 'open-uri'
require 'json'

class Api::V1::PlacesController < ApplicationController
  def get_places
    base_url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'

    key = '?key=AIzaSyB8Jg0gTB-KAwT5VeHkUg_ZlmisRAk0pqI'
    type = "&type=#{params[:type]}"
    radius = "&radius=#{params[:radius]}"
    location = "&location=#{params[:location]}"
    # location = '&location=40.7052569,-74.0162643'

    final_url = "#{base_url + key + location + type + radius}"

    uri = URI.parse(final_url)
    response = Net::HTTP.get_response(uri)
    response.body
    result = JSON.parse(response.body)


    render json: {locations: result}
  end

  def get_place
    url = 'https://maps.googleapis.com/maps/api/place/details/json'

    place_id = "&place_id=#{params[:place_id]}"
    key = '?key=AIzaSyB8Jg0gTB-KAwT5VeHkUg_ZlmisRAk0pqI'

    final_url = "#{url + key + place_id}"

    uri = URI.parse(final_url)
    response = Net::HTTP.get_response(uri)
    response.body
    result = JSON.parse(response.body)

    render json: {locations: result, path: final_url}
  end

  def get_picture
    url = 'https://maps.googleapis.com/maps/api/place/photo'

    key = '?key=AIzaSyB8Jg0gTB-KAwT5VeHkUg_ZlmisRAk0pqI'
    picture_id = "&photoreference=#{params[:picture_id]}"
    # 1280 x 720

    final_url = "#{url + key + picture_id}&maxwidth=400"

    uri = URI.parse(final_url)
    response = Net::HTTP.get_response(uri)
    # result = response.body

    picture_url = response.body.split("A HREF=\"") # remove first part of "A" HTML TAG
    picture_url = picture_url[1].split("\">here") # remove second part of "A" HTML TAG

    render json: {picture: picture_url[0]}
  end

end
