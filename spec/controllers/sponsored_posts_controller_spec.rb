require 'rails_helper'
include RandomData

RSpec.describe SponsoredPostsController, type: :controller do
  let(:my_sponsored_post) do
    SponsoredPost.create(
      id: 1,
      title: RandomData.random_sentence,
      body: RandomData.random_paragraph,
      price: 99
    )
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: {id: my_sponsored_post.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, params: {id: my_sponsored_post.id}
      expect(response).to render_template :show
    end

    it "assigns my_sponsored_post to @sponsoredPost" do
      get :show, params: {id: my_sponsored_post.id}
      expect(assigns(:sponsoredPost)).to eq(my_sponsored_post)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
      end

    it "instantiates @sponsoredPost" do
      get :new
      expect(assigns(:sponsoredPost)).not_to be_nil
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

end
