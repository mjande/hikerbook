class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[edit update destroy]

  def index
    @posts = Post.where(user: current_user.friends)
    render layout: 'home'
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = 'Post successfully created'
      respond_to do |format|
        format.html { redirect_to root_path }
        format.turbo_stream
      end
    else
      flash.now[:notice] = 'Something went wrong'
      render 'new', status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:success] = "Post was successfully updated"
      respond_to do |format|
        format.html { redirect_to posts_path }
      end
    else
      flash.now[:notice] = "Something went wrong"
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = 'Post was successfully deleted.'
      respond_to do |format|
        format.html { redirect_to posts_path }
        format.turbo_stream
      end
    else
      flash.now[:error] = 'Something went wrong'
      redirect_to posts_path
    end
    
  end

  private

  def post_params
    params.require(:post).permit(:trail, :park, :description)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
