require 'rspec/given' 
require 'spec_helper'
describe PostsController do
  Given(:post1) { Post.create! }
  Given(:post2) { Post.create! }
  Given(:user) { FactoryGirl.create(:user) }
  context "GET #index" do
    When { get :index }
      context "renders the index template" do
        Then { expect(response).to render_template("index") }
      end
      context "loads all of the posts into @posts" do
        Then { expect(assigns(:posts)).to match_array([post1,post2]) }
      end
  end

  context "GET #new" do
    before do
      sign_in user
    end
    When { get :new}
      context "renders the new template" do
        Then { expect(response).to render_template("new")}
      end
  end
end
