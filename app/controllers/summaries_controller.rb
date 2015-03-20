class SummariesController < ApplicationController
  def new
      @topic = Topic.find(params[:topic_id])
      @post = Post.find(params[:post_id])
    @summary = Summary.new
    authorize @summary
  end
  
  def show
      @topic = Topic.find(params[:topic_id])
      @post = Post.find(params[:post_id]).summary
  end
  
  def create
       @topic = Topic.find(params[:topic_id]) #find the topic id
       @post = Post.find(params[:post_id]) #find the post id
      @summary = Summary.new(params.require(:summary).permit(:name, :description)) #create/build the summary
      @summary.post = @post
      authorize @summary
      if @summary.save
        flash[:notice] = "Summary was saved."
        redirect_to [@topic, @post, @summary] #go to the summary page
      else
        flash[:error] = "There was an error saving the summary. Please try again."
        render :show #new makes no sense to me
      end
  end
end
