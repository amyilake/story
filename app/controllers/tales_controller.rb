class TalesController < ApplicationController
  
  before_action :login_required, :only => [:new, :create, :edit, :update, :destroy]
  
  def index
    if params[:user_id] != "" && params[:user_id] != nil
      user = User.find(params[:user_id])
      @tales = user.tales.paginate(:page => params[:page]).order("created_at desc")
    else
      @tales = Tale.paginate(:page => params[:page]).order("created_at desc")
    end
    
    respond_to do |format|
      format.html
      format.json do
        render :json => @tales, :each_serializer => TaleSerializer
      end
    end
  
  end

  def show
    @tale = Tale.find(params[:id])
    @posts = @tale.posts
  end

  def new
    @tale = Tale.new
    @tale.posts.build(:author_id => current_user.id)
  end

  def create
    @tale = current_user.tales.build(tale_params)
    if @tale.save
      redirect_to tales_path
    else
      render :new
    end
  end

  def edit
    @tale = current_user.tales.find(params[:id])
    @posts = @tale.posts
  end

  def update
    @tale = current_user.tales.find(params[:id])
    if @tale.update_attributes(tale_params)
      redirect_to tales_path, notice: "Successfully updated tale."
    else
      render :edit
    end
  end

  def destroy
    @tale = current_user.tales.find(params[:id])
    @tale.destroy
    redirect_to tales_path, notice: "Successfully destroy tale."
  end

  private
  def tale_params
    params.require(:tale).permit(
      :id, :title, :content, :author_id, :type, :likes_count, 
      :comments_count, :favorite, :image, :remote_image_url,
      posts_attributes: [:id, :title, :content, :author_id,
                         :image, :remote_image_url, :_destroy]
    )
  end

end
