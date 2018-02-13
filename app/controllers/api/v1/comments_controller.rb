class Api::V1::CommentsController < ApplicationController
  def show
    @comments = Comment.where(["place_id = ?", params[:placeId]])
    # @comments = Comment.all.select{|comment| comment.place_id == params[:placeId]}

    render json: {comments: @comments}
  end

  def create
    @user = User.find(params[:userId])
    @comment = Comment.new(content: params[:content], user: @user, place_id: params[:placeId])

    if @comment.save
      render json: {comment: @comment}
    else
      render json: {error: "Invalid comment"}
    end
  end

  def update
    @comment = Comment.find(params[:commentId])
    @comment.content = params[:content]

    if @comment.save
      render json: {comment: @comment}
    else
      render json: {error: "Unable to save comment"}
    end
  end

  def destroy
    @comment = Comment.find(params[:commentId])

    if @comment.destroy
      render json: {message: "Comment deleted"}
    else
      render json: {error: "Unable to delete comment"}
    end
  end

end
