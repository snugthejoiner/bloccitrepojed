class PostsController < ApplicationController
  
  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
      authorize @post
  end

  def show
    @post = Post.find(params[:id])
    @topic = Topic.find(params[:topic_id])
  end
  
    def create
      @topic = Topic.find(params[:topic_id])
      @post = current_user.posts.build(params.require(:post).permit(:title, :body))
      authorize @post
      if @post.save
        flash[:notice] = "Post was saved."
        redirect_to @post
      else
        flash[:error] = "There was an error saving the post. Please try again."
        render :new
      end
    end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
      authorize @post
  end
  
    def update
      @post = Post.find(params[:id])
       authorize @post
      if @post.update_attributes(params.require(:post).permit(:title, :body))
        flash[:notice] = "Post was updated."
        redirect_to @post
      else
        flash[:error] = "There was an error saving the post. Please try again."
        render :edit
      end
    end
end

   def update
     @topic = Topic.find(params[:topic_id])
     authorize @topic
     if @topic.update_attributes(params.require(:topic).permit(:name, :description, :public))
       redirect_to @topic
     else
       flash[:error] = "Error saving topic. Please try again."
       render :edit
     end
   end
