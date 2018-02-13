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

    if @favorite.destroy
      render json: {message: 'Favorite Removed'}
    else
      render json: {error: 'Could not delete favorite'}
    end
  end

end
