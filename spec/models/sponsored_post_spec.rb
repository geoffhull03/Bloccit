require 'rails_helper'

RSpec.describe SponsoredPost, type: :model do
  context "attributes" do
    let(:sponsoredpost) {SponsoredPost.new(title: "New Sponsored Post", body: "Sponsored Post Body", price: 99)}
  end

  it "should respond to a title" do
    expect(question).to respond_to(:title)
  end

  it "should respond to body" do
    expect(question).to respond_to(:body)
  end

  it "should respond to resolved" do
    expect(question).to respond_to(:resolved)
  end
end
