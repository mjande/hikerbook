class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[edit update destroy]

  def index
    @posts = Post.where(user: current_user.friends).or(Post.where(user: current_user)).order(created_at: :desc).includes(:likes)
    render layout: 'home'
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      respond_to do |format|
        format.html { redirect_to root_path, flash: { success: 'Post was successfully created' } }
        format.turbo_stream { flash.now[:success] = 'Post was successfully created' }
      end
    else
      # Error messages will be displayed above _form, rather than in the flash hash.
      render 'new', status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      respond_to do |format|
        format.html { redirect_to posts_path, flash: { success: 'Post was successfully updated' } }
        format.turbo_stream { flash.now[:success] = 'Post was successfully updated' }
      end
    else
      # Error messages will be displayed above _form, rather than in the flash hash.
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy

      respond_to do |format|
        format.html { redirect_to posts_path, flash: { success: 'Post was successfully deleted' } }
        format.turbo_stream { flash.now[:success] = 'Post was successfully deleted' }
      end
    else
      flash.now[:error] = 'Something went wrong!'
      render posts_path, status: :unprocessable_entity
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
