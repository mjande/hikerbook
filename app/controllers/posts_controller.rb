class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[edit update destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = 'Post successfully created'
      redirect_to root_path
    else
      flash[:error] = 'Something went wrong'
      render 'new', status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:success] = "Post was successfully updated"
      redirect_to posts_path
    else
      flash[:error] = "Something went wrong"
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = 'Post was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:trail, :park, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
