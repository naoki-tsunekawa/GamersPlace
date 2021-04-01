class ReviewsController < ApplicationController
  # レビュー機能をログインしているユーザのみ使用可能
  before_action :logged_in_user, only: [:create, :index]

  def index
    @game = Game.find(params[:game_id])
    @reviews = @game.reviews
  end

  def create
    # フォームより受け取った値を保存
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    # review保存処理
    if @review.save
      redirect_to game_reviews_path(@review.game)
    else
      # 保存されなかった場合
      @game = Game.find(@review.game_id)
      @post = @game.posts.build if logged_in?
      @posts = @game.posts.all
      render "games/show"
    end
  end

  private
  def review_params
    params.require(:review).permit(:game_id, :score, :content)
  end
end
