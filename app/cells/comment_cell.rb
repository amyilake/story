class CommentCell < Cell::Rails

  def show(args)
    @post = args[:post]
    @current_user = args[:current_user]
    @comments = @post.comments
    @comment = Comment.new(:commentable => @post)
    render
  end

end
