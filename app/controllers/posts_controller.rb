class PostsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]

  def create
    @post = Posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:content, :user_id, :game_id)
  end
end
