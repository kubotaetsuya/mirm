class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: 'desc')
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
    @tag_lists = Tag.all
    @user = current_user
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    tag_list = params[:post][:tag_ids].split(',')
    if @post.valid?
      @post.save
      @post.save_tags(tag_list)
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
    @user = current_user
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
  end

  def search
    if @posts = Post.search(params[:keyword])
    else
      @posts = Post.search(tag.id) 
    end
    @user = current_user 
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :image, tag_ids: []).merge(user_id: current_user.id)
  end
end
