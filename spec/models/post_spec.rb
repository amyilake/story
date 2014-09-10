require 'rspec/given'
require 'rails_helper'

describe Post do
 
  context "#truncate_sanitize_content" do
    Given(:testString) { "<div>"+"0"*110+"</div>" }
    Given(:post) { create(:post, :content => testString ) }
    When(:content) { post.truncate_sanitize_content }
    Then { content == " "+"0"*97+".." }
  end
  
  Given(:user) { create(:user) }
  Given(:post) { create(:post, :author => user) }
  
  context "#liked_people" do
    #"[{\"author\":{\"name\":\"Ilake Chang\",\"image\":\"/uploads/user/image/16/thumb_382544_10201260866145302_1606023751_n.jpg\",\"url\":\"/users/16/posts\",\"id\":16}}]"
    Given(:like) { create(:like, :author => user, :liketable => post) }
    When(:result) { post.liked_people }
    Then { result = ActiveModel::ArraySerializer.new([like], each_serializer: LikeSerializer).to_json }
    #Then { result.include?("[{\"author\":{\"name\":\"foo1\",\"image\":null,") }
  end

  context "#comment_people" do
    Given(:comment) { create(:comment, :author => user, :commentable => post) }
    When(:result) { post.comment_people }
    Then { result = ActiveModel::ArraySerializer.new([comment], each_serializer: CommentSerializer).to_json }
  end
end 
