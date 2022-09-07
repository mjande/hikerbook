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
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Post successfully created' }
        format.turbo_stream
      end
    else
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
    params.require(:post).permit(:trail, :park, :description)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
