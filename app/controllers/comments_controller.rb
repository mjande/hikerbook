class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comments

  def index; end

  def new
    @comment = Comment.new(post_id: params[:post_id])
  end

  def create
    @comment = @post.comments.build(comment_params)

    if @comment.save
      redirect_to post_comments_path(@post)
    else
      render 'new'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      redirect_to post_comments_path(@post)
    else
      render 'edit'
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comments
    @comments = @post.comments.all
  end

  def comment_params
    params.require(:comment).permit(:user_id, :body)
  end
end
