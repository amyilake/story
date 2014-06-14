class LikeSerializer < ActiveModel::Serializer

  has_one :author, serializer: AuthorSerializer
end
