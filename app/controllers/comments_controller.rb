class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    if comment.valid?
      comment.save
      redirect_to "/posts/#{comment.post_id}"  # コメントと結びつくツイートの詳細画面に遷移する
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
