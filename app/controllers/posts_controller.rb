class PostsController < ApplicationController 
  before_action :login_required, :only => [  :new, :create, :edit, :update, :destroy]

  def index
    if params[:user_id] != "" && params[:user_id] != nil
      user = User.find(params[:user_id])
      @posts = user.posts.limit(8).order("created_at desc")
    else
      @posts = Post.all.limit(8).order("created_at desc")
    end
    @posts = @posts.offset((params[:page].to_i-1) * 8) if params[:page].present?
   
    respond_to do |format|
      format.html
      format.json do
        render :json => @posts, :each_serializer => PostSerializer
      end
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
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

  def likedPeople
    @post = Post.find(params[:post_id])
    
    respond_to do |format|
      format.js { render "liked_comment_people", 
        :locals => {
          :people => @post.liked_people,
          :text => "這些人覺得很贊"
        } 
      }
    end
  end

  def commentPeople
    @post = Post.find(params[:post_id])
    
    respond_to do |format|
      format.js { render "liked_comment_people", 
        :locals => {
          :people => @post.comment_people,
          :text => "留言"
        } 
      }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :author_id, :type, :likes_count, :comments_count, :favorite, :image, :remote_image_url)
  end
end
