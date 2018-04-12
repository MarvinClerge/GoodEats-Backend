class Api::V1::UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.valid?
      # @user.save
      token = issue_token({ 'user_id': @user.id })
      render json: {user: @user, token: token}
    else
      render json: @user.errors, status: 401
    end
  end

  def login
    @user = User.find_by(username: user_params[:username])

    if @user && @user.authenticate(user_params[:password])
      token = issue_token({ 'user_id': @user.id })
      render json: {user: @user, token: token}
    else
      render json: {error: 'Username and password do not match'}, status: 401
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
