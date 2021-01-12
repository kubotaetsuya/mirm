class PostsController < ApplicationController
  
  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    tag_list = params[:post][:tag_ids].split(',')
    if @post.save
      @post.save_tags(tag_list)
      redirect_to root_path
    else
      render :new
    end
  end
  
  private

  def post_params
    params.require(:post).permit(:title, :text, :image).merge(user_id: current_user.id)
  end
end
