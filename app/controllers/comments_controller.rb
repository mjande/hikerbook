class CommentsController < ApplicationController
  before_action :set_post, except: %i[edit update]
  before_action :set_comment, only: %i[edit update destroy]

  def index; end

  def new
    @comment = Comment.new(post_id: params[:post_id])
  end

  def create
    @comment = @post.comments.build(comment_params)

    if @comment.save
      respond_to do |format|
        format.html { redirect_to post_path(@post) }
        format.turbo_stream
      end
    else
      # Error messages will be displayed above _form, rather than in the flash hash.
      render 'new'
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      respond_to do |format|
        format.html { redirect_to post_path(@comment.post) }
        format.turbo_stream 
      end
    else
      # Error messages will be displayed above _form, rather than in the flash hash.
      render 'edit'
    end
  end

  def destroy
    if @comment.destroy
      respond_to do |format|
        format.html { redirect_to post_path(@post) }
        format.turbo_stream
      end
    else
      flash[:error] = 'Something went wrong'
      redirect_to post_path(@post)
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:user_id, :body)
  end
end
