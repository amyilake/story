class AuthorSerializer < ActiveModel::Serializer
  attributes :name, :image, :url
  
  def image
    object.image_url(:thumb)
  end

  def url
    url = user_posts_path(object.id)
  end
end
