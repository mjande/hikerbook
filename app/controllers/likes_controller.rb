class LikesController < ApplicationController
  before_action :build_like, only: :create
  before_action :set_like, only: :destroy

  def create
    if @like.save
      respond_to do |format|
        format.html { redirect_to posts_path }
        format.turbo_stream { render 'posts/likes/update' }
      end
    else
      flash.now[:error] = 'Something went wrong'
      render 'new'
    end
  end

  def destroy
    if @like.destroy
      respond_to do |format|
        format.html { redirect_to posts_path }
        format.turbo_stream { render 'posts/likes/update' }
      end
    else
      flash.now[:error] = 'Something went wrong'
      redirect_to posts_path
    end
  end

  private

  def build_like
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user_id: params[:user])
  end

  def set_like
    @post = Post.find(params[:post_id])
    @like = Like.find(params[:id])
  end
end
