require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:topic) { create(:topic) }
  let(:user) { create(:user) }
  let(:post) { create(:post) }

   it { is_expected.to have_many(:comments) }
   it { is_expected.to have_many(:votes) }
   it { is_expected.to have_many(:favorites) }
   it { is_expected.to belong_to(:topic) }
   it { is_expected.to belong_to(:user) }

   it { is_expected.to validate_presence_of(:title) }
   it { is_expected.to validate_presence_of(:body) }
   it { is_expected.to validate_presence_of(:topic) }
   it { is_expected.to validate_presence_of(:user) }

   it { is_expected.to validate_length_of(:title).is_at_least(5) }
   it { is_expected.to validate_length_of(:body).is_at_least(20) }

   context "voting" do
     let!(:name) { RandomData.random_sentence }
     let!(:description) { RandomData.random_paragraph }
     let!(:title) { RandomData.random_sentence }
     let!(:body) { RandomData.random_paragraph }

     let!(:topic) { Topic.create!(name: name, description: description) }

     let!(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
     let!(:post) { topic.posts.create!(title: title, body: body, user: user) }

     let!(:setup) do
       3.times { post.votes.create!(value: 1, user: user) }
       2.times { post.votes.create!(value: -1, user: user) }
       @up_votes = post.votes.where(value: 1).count
       @down_votes = post.votes.where(value: -1).count
     end


     describe "attributes" do
       it "has a title, body, and user attribute" do
         expect(post).to have_attributes(title: post.title, body: post.body, user: user)
       end
     end

     describe "#up_votes" do
       it "counts the number of votes with value = 1" do
         expect( post.up_votes ).to eq(@up_votes)
       end
     end

     describe "#down_votes" do
       it "counts the number of votes with value = -1" do
         expect( post.down_votes ).to eq(@down_votes)
       end
     end

     context "#points" do
       it "returns the sum of all down and up votes" do
         expect( post.points ).to eq(@up_votes - @down_votes)
       end
     end

     context "#update_rank" do
       let!(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }

       it "calculates the correct rank" do
         post.update_rank
         expect(post.rank).to eq (post.points + (post.created_at - Time.new(1970,1,1)) / 1.day.seconds)
       end

       it "updates the rank when an up vote is created" do
         old_rank = post.rank
         post.votes.create!(value: 1, user: user)
         expect(post.rank).to eq (old_rank + 1)
       end

       it "updates the rank when a down vote is created" do
         old_rank = post.rank
         post.votes.create!(value: -1, user: user)
         expect(post.rank).to eq (old_rank - 1)
       end
     end

     context "create_vote" do
       it "sets the post up_votes to 1" do
         expect(post.up_votes).to eq(4)
       end

       it "associates the vote with the owner of the post" do
         puts post.user.inspect
         puts post.votes.first.user.inspect
         expect(post.votes.first.user).to eq(post.user)
       end
     end
   end
end
