class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
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
    @post.destroy
    @game = Game.find(@post.game_id)
    flash[:success] = "post deleted"
    redirect_to request.referrer || game_path(@game)
  end

  private

  def post_params
    params.require(:post).permit(:content, :user_id, :game_id)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end
