class LikesController < ApplicationController
    before_action :authenticate_user!

    def new_user_like
        @user = current_user
        @post = Post.find(params[:post_id])
        like = Like.find_by(user_id: @user.id, post_id: @post.id)
        if like
            return flash.now[:alert] = "Ya Has reaccionado a este post"
        else
            @new_like = Like.new(user_id: @user.id, post_id: @post.id, kind: params[:kind])
            respond_to do |format|
                if @new_like.save!
                    format.html {redirect_to post_url(@post), notice: "Acabas de reaccionar satisfactoriamente"}
                else
                    format.html {redirect_to post_url(@post), status: :unprocessable_entity}
                end
            end
        end
    end
end
