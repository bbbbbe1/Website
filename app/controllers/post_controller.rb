class PostController < ApplicationController
	  protect_from_forgery with: :exception

	before_action :authenticate_user!, except:[:index, :show]  

  def new
  end

  def mypage
    @listPosts = current_user.posts.reverse
  end

  def create
    newPost = Post.new
    newPost.title = params[:title]
    newPost.content = params[:content]
    newPost.user = current_user
    if params[:avatar]
      newPost.avatar = params[:avatar]
    end
    newPost.save
    
    redirect_to "/show/#{newPost.id}"
  end

  def destroy
    destroyPost = Post.find(params[:id])
    destroyPost.destroy
    
    redirect_to '/'
  end

  def index
    @listPost = Post.order("created_at DESC").paginate(:page => params[:page], :per_page => 7)
  end

  def show
    @showPost = Post.find(params[:id])
  end

  def edit
    @editPost = Post.find(params[:id])
  end

  def update
    updatePost = Post.find(params[:id])
    updatePost.title = params[:title]
    updatePost.content = params[:content]
    updatePost.save
    
    redirect_to "/show/#{updatePost.id}"
  end

  
end
