class PostsController < ApplicationController
  def index 
    @posts = Post.all.with_attached_image
  end
  def create
    @post = Post.new(params.require(:post).permit(:description, :image))
    @post.account = current_account
    @post.image.attach(params[:post][:image])
    if @post.save
      flash[:notice] = "Post created successfully"
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

end
