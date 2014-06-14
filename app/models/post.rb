class Post < ActiveRecord::Base
  belongs_to :author, :class_name => 'User'
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :likes, :as => :liketable, :dependent => :destroy

  validates :image, :presence => { :message => "Story image is required" }
  mount_uploader :image, ImageUploader

  def liked_people
    ActiveModel::ArraySerializer.new(self.likes, each_serializer: LikeSerializer).to_json
    #self.likes.map { |like| like.author }
  end

  def comment_people
    ActiveModel::ArraySerializer.new(self.comments, each_serializer: CommentSerializer).to_json
    #self.comments.map { |comment| comment.content }
  end

end
