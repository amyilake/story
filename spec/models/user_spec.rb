require 'rspec/given'
require 'rails_helper'

describe User do
   def user_init
     user = create(:user)
   end

  context "when use init" do
    Given(:user) { user_init }
    Then {  user.name.include? "foo" } 
    
    context "when name is not present" do
      Given(:user) { User.new() }
      Then { should_not be_valid }
    end
  end

  context '#check_like_post?' do
    Given(:user)  { build_stubbed(:user) }
    Given(:post) { create(:post) }

    context 'when user ever liked this post' do
      Given!(:like) { create(:like, :author => user, :liketable => post) }
      When(:result) { user.check_like_post?(post) }
      Then { result == true }
    end

    context 'when user never like this post' do
      When(:result) { user.check_like_post?(post) }
      Then { result == false }
    end
  end
end
