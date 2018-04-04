class Api::V1::UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.valid?
      # @user.save
      render json: @user
    else
      render json: {errors: @user.errors}, status: 401
    end
  end

  def login
    u = User.find_by(username: params[:username])

    # if @user && @user.authenticate(params[:password])
    #   render json: {id: @user.id, username: @user.username, token: encode_token({'user_id': @user.id})}
    if u && u.authenticate(params[:password])
      favorites = u.favorites.map {|favorite| favorite.place_id}
      token = issue_token({ 'user_id': u.id })

      render json: {user: u, favorites: favorites, 'token': token}
    else
      render json: {error: "Username and password do not match"}, status: 401
    end
  end

  def find_current_user
    u = current_user
    if u
      favorites = u.favorites.map {|favorite| favorite.place_id}
      render json: {user: u, favorites: favorites}
    else
      render json: {error: 'User Not Found'}, status: 401
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

end
