class PostsController < ApplicationController 
  before_action :login_required , :only => [  :new  , :create , :edit , :update , :destroy]

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      @posts = user.posts
    else
      @posts = Post.all#.includes(:comments)
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.save
    redirect_to posts_path
  end

  def show 
    @post = Post.find(params[:id])
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    @post.update(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private
    def post_params
      params.require(:post).permit!
    end

end
