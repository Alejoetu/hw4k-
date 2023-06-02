class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by({ "id" => params["id"] })
    @place = Place.find_by({ "id" => @post["place_id"] })
  end
  
  def new
    if @current_user
      @posts = Post.where({ "user_id" => @current_user["id"] })
      @post = Post.new
      @post["place_id"] = @place["id"]
    end
  end

  def create
    @post = Post.new
    @post["title"] = params["post"]["title"]
    @post["description"] = params["post"]["description"]
    @post["posted_on"] = params["post"]["posted_on"]
    @post["place_id"] = @post["place_id"]
    @post["user_id"] = @current_user["id"]
    @post.save
    redirect_to "/places/#{@post["place_id"]}"
  end
  def destroy
    @post = Post.find_by({ "id" => params["id"] })
    if @post["user_id"] == @current_user["id"]
      @post.destroy
    end
    redirect_to "/places"
  end
end
