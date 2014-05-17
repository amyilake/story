class CommentsController < ApplicationController
   
  before_action :login_required , :only => [ :new  , :create ]

  def new
    @commentable =Post.find(params[:post_id])
    @comment = @commentable.comments.new()
  end

  def create
    @commentable = Post.find(params[:post_id])
    @comment = @commentable.comments.new(comment_params)
    if @comment.save
      redirect_to post_path(@commentable), notice: "Comment created."
    else
      render :new
    end
  end

  private
    def comment_params
      params.require(:comment).merge(:author_id => current_user.id ).permit!
    end
end
