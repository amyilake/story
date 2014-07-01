class TaleSerializer < ActiveModel::Serializer
  
  attributes :id, :comments_count, :likes_count, :content
  
  has_one :author, serializer: AuthorSerializer
  has_many :posts, seriallzer: PostSerializer

end
