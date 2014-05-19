class LikesController < ApplicationController
  before_action :login_required , :only => [:create]

  def create
    @liketable = Post.find(params[:post_id])
    @like = @liketable.likes.new
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


end
