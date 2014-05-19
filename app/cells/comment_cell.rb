class CommentCell < Cell::Rails

  def show(args)
    @post = args[:post] 
    @comments = @post.comments
    @comment = Comment.new(:commentable => @post)
    render
  end

end
