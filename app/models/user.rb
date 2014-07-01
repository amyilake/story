class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, omniauth_providers: [:facebook]

  has_many :posts, :foreign_key => :author_id, :dependent => :destroy
  has_many :comments, :foreign_key => :author_id, :dependent => :destroy
  has_many :tales, :foreign_key => :author_id, :dependent => :destroy

  #validates_presence_of :image

  mount_uploader :image, ImageUploader

  after_update :touch_all_comments


  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.name = auth.info.name
      user.remote_image_url = auth.info.image.gsub('http://','https://')
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end    
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def email_required?
    super && provider.blank?
  end
  

  def check_like_post?(post)
    post.likes.map { |like| like.author_id }.include?(self.id)
  end

  protected
  def touch_all_comments
    posts.update_all(:updated_at => Time.zone.now)
  end

end
