class SponsoredPostsController < ApplicationController
  def show
    @sponsoredPost = SponsoredPost.find(params[:id])
  end

  def new
    @sponsoredPost = SponsoredPost.new
  end

  def edit
  end
end
