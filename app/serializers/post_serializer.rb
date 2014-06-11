class PostSerializer < ActiveModel::Serializer
 include ActionView::Helpers::TextHelper

  delegate :current_user, to: :scope

  attributes :id, :comment_count, :like_count 
  attributes :title, :photo, :url, :like_text, :like_method, :like_url, :liked_people_url
  
  has_one :author, serializer: AuthorSerializer

  def title 
    title = truncate( object.title , length: 25, omission: '..')
  end

  def photo
    if object.image_url.present?
      post_photo = object.image_url
    else
      post_photo = "/assets/baby.jpg"
    end
  end

  def url
    url = post_url(object)
  end

  def like_text
    if current_user && current_user.check_like_post?(object)
      like_text = "收回贊"
    else
      like_text = "贊"
    end
  end

  def like_method
    if current_user && current_user.check_like_post?(object)
      like_method = "delete"
    else
      like_method = "post"
    end
  end

  def like_url
    post_likes_path(object)
  end

  def liked_people_url
    post_likedPeople_path(object)
  end
end
