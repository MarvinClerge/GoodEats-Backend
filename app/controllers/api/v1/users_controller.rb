class Api::V1::UsersController < ApplicationController
  def signup
    @user = User.new(username: params[:username], password: params[:password])

    if @user.save
      render json: {user: @user}
    else
      render json: {error: "Invalid Entry"}, status: 401
    end
  end

  def login
    u = User.find_by(username: params[:username])

    # if @user && @user.authenticate(params[:password])
    #   render json: {id: @user.id, username: @user.username, token: encode_token({'user_id': @user.id})}
    if u && u.authenticate(params[:password])
      token = issue_token({ 'user_id': u.id })
      render json: {id: u.id, 'token': token }
    else
      render json: {error: "Username and password do not match"}, status: 401
    end
  end

  def find_current_user
    u = current_user
    if u
      render json: {username: u.username, favorites: u.favorites}
    else
      render json: {error: 'User Not Found'}, status: 401
    end
  end

end
