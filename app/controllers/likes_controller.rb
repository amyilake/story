class LikesController < ApplicationController
  
  before_action :login_required, :only => [ :create ]

  def create
    @liketable = Post.find(params[:post_id])
    @like = @liketable.likes.new(:author_id => current_user.id)
    @like.save
    
    if @like
      respond_to do |format|
        format.html { redirect_to posts_path } #render :nothing => true, :status => 201
        format.js
      end
    else
      render :nothing => true, :status => 422
    end
  end

  def destroy
    @liketable = Post.find(params[:post_id])
    @like = @liketable.likes.find_by_author_id(current_user)
    @like.destroy

    respond_to do |format|
      #format.js { render :file => "likes/create.js.erb" }
      format.js
    end
  end

end
