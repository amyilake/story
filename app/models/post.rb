class Post < ActiveRecord::Base
  belongs_to :author, :class_name => 'User'
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :likes, :as => :liketable, :dependent => :destroy

  mount_uploader :image, ImageUploader

  def liked_people
    self.likes.map { |like| like.author }
  end


end
