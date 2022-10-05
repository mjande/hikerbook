# frozen_string_literal: true

# The LikesController handles the REST actions for the Like model.
class LikesController < ApplicationController
  before_action :build_like, only: :create
  before_action :set_like, only: :destroy
  before_action :set_posts

  def create
    if @like.save
      respond_to do |format|
        format.html { redirect_to posts_path }
        format.turbo_stream { render 'posts/likes/update' }
      end
    else
      flash.now[:error] = 'Something went wrong'
      render 'posts/index', status: :unprocessable_entity
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
      render 'posts/index', status: :unprocessable_entity
    end
  end

  private

  def build_like
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)
  end

  def set_like
    @post = Post.find(params[:post_id])
    @like = Like.find(params[:id])
  end

  def set_posts
    @posts = Post.all
  end
end
