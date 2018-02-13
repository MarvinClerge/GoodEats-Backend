class Api::V1::FavoritesController < ApplicationController
  def add_favorite
    @user = User.find(params[:userId])
    @favorite = Favorite.new(place_id: params[:placeId], user: @user)

    if @favorite.save
      render json: {favorite: @favorite}
    else
      render json: {error: 'Invalid Favorite'}, status: 401
    end
  end

  def remove_favorite
    @user = User.find(params[:userId])
    @favorite = Favorite.find_by(place_id: params[:placeId], user: @user)

    @favorite.destroy

    if @favorite
      render json: {error: 'Unable to Find Favorite'}
    else
      render json: {success: 'Favorite Removed'}
    end
  end

end

# User.first.favorites.map {|favorite| favorite.place_id }
