class PostsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]

  def create
    # @game = Game.find(params[:game_id])
    # @user = User.find(params[:user_id])
    @game = Game.find(params[:post][:game_id])
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to game_path(@game)
    else
      flash[:danger] = "メッセージを入力してください。"
      redirect_to game_path(@game)
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:content, :user_id, :game_id)
  end
end
