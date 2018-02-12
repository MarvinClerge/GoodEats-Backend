class Api::V1::UsersController < ApplicationController
  def create
    @user = User.new(username: params[:username], password: params[:password])

    if @user.save
      render json: {user: @user}
    else
      render json: {error: "Invalid Entry"}, status: 401
    end
  end

end
