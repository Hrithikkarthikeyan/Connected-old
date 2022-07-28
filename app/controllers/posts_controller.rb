class PostsController < ApplicationController
  def index 
    @posts = Post.all.includes(:account, :likes).with_attached_image.order('created_at DESC')
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
    @likes = @post.likes.include(:account)
    @comment = Comment.new
    @is_liked = @post.is_liked(current_account)
  end

  def new
    @post = Post.new
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to @post
end
end
