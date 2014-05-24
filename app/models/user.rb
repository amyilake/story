class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, :foreign_key => :author_id, :dependent => :destroy
  has_many :comments, :foreign_key => :author_id, :dependent => :destroy

  validates_uniqueness_of :name
  validates_presence_of :image

  mount_uploader :image, ImageUploader

  after_update :touch_all_comments

  protected
  def touch_all_comments
    posts.update_all(:updated_at => Time.zone.now)
  end
end
