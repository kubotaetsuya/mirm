class PostsController < ApplicationController
  before_action :move_to_index, only: [:edit, :destroy]
  before_action :set_post, only: [:edit, :show]
  before_action :set_current_user, only: [:index, :show, :search]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all.order(created_at: 'desc')
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
    @tag_lists = Tag.all
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
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path
  end

  def edit
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
  end

  def search
    @posts = Post.search(params[:keyword])
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :image, tag_ids: []).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to root_path unless user_signed_in? && current_user.id == Post.find(params[:id]).user_id
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_current_user
    @user = current_user
  end
end
