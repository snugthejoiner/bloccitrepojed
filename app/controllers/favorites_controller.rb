class FavoritesController < ApplicationController
    def create
        post = Post.find(params[:post_id])
        favorite = current_user.favorites.build(post: post)
        authorize favorite
        if favorite.save
            flash[:notice] = "Post has been favorited."
            redirect_to [post.topic, post]
        else
            flash[:notice] = "There was an error. Please try again."
            redirect_to [post.topic, post]
        end
    end
    
    def destroy
        post = Post.find(params[:post_id])
        favorite = current_user.favorites.find(params[:id])
        authorize favorite
        if favorite.destroy
            flash[:notice] = "Post is no longer a favorite."
            redirect_to [post.topic, post]
        else
            flash[:notice] = "There was an error. Please try again."
            redirect_to [post.topic, post]
        end
    end
end