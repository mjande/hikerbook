class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comments

  def index; end

  def new
    @comments = @post.comments.all
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
