require 'rspec/given' 
require 'spec_helper'
describe PostsController do
  context "GET #index" do
    When { @post1, @post2 = Post.create!, Post.create! }
    When { get :index }
      context "renders the index template" do
        Then { expect(response).to be_success }
        Then { expect(response).to render_template("index") }
      end
      context "loads all of the posts into @posts" do
        Then { expect(assigns(:posts)).to match_array([@post1,@post2]) }
      end
  end
end
