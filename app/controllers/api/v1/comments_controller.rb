class Api::V1::CommentsController < ApplicationController
  def show
    @comments = Comment.where(["place_id = ?", params[:placeId]])
    @comments = @comments.sort_by{|comment| comment.created_at}

    @comments = @comments.map do |comment|
      comment = {comment: comment, username: comment.user.username, user_id: comment.user.id}
    end

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
    @comments = Comment.all.take(10)

    if @comment.destroy
      render json: {message: "Comment deleted", comments: @comments}
    else
      render json: {error: "Unable to delete comment"}
    end
  end

end
