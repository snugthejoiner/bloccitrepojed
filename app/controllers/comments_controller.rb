class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(params.require(:comment).permit(:body)) 
    @comment.post = @post
    @topic = @post.topic
    authorize @comment
    if @comment.save
      flash[:notice] = "Comment was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      redirect_to [@topic, @post]
    end
  end
    
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @topic = @post.topic
    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment was removed."

    else
      flash[:error] = "Comment couldn't be deleted. Try again."

    end
    
    respond_to do |format|
      format.html
      format.js
    end
    
  end
    
end
