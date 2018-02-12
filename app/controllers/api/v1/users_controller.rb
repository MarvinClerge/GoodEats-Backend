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
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      render json: {id: @user.id, username: @user.username, token: encode_token({'user_id': @user.id})}
    else
      render json: {error: "Username and password do not match"}, status: 401
    end
  end

end
