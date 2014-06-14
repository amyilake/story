class CommentSerializer < ActiveModel::Serializer
  attributes :content
  has_one :author, serializer: AuthorSerializer

end
