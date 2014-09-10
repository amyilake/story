require 'rspec/given' 
require 'rails_helper'

describe PostsController, :type => :controller do
  include Devise::TestHelpers
  Given(:post1) { create(:post) }
  Given(:post2) { create(:post) }
  Given(:user) { create(:user) }

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
