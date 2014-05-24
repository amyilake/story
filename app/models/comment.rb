class Comment < ActiveRecord::Base
  belongs_to :commentable , polymorphic: true
  belongs_to :author , :class_name => "User"


  after_create :increase_comment_counter
  after_destroy :decrease_comment_counter

  
  def increase_comment_counter
    commentable.increment(:comment_count, 1)
    commentable.save
  end

  def decrease_comment_counter
    commentable.increment(:comment_count , -1)
    commentable.save
  end
end

