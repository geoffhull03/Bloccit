require 'rails_helper'

RSpec.describe SponsoredPost, type: :model do
  let (:sponsoredPost) { SponsoredPost.create! }

  describe "attributes" do
    it "should respond to title" do
      expect(sponsoredPost).to respond_to(:title)
    end

    it "should respond to body" do
      expect(sponsoredPost).to respond_to(:body)
    end

    it "should respond to price" do
      expect(sponsoredPost).to respond_to(:price)
    end
  end
end
