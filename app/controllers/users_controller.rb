class UsersController < ApplicationController
  # index,edit,update,destroyアクションはログイン状態でしか機能しない
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  # 正しいユーザの時のみedit,updateアクションは機能しない
  before_action :correct_user, only: [:edit, :update]
  # adminユーザのみdestroyアクションは機能しない
  before_action :admin_user, only: :destroy

  def index
    @users = User.page(params[:page]).per(10)
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # ユーザ作成時にログイン
      log_in @user
      flash[:success] = "Welcome to the GamersPlace!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # # ログイン済みユーザーかどうか確認
  # def logged_in_user
  #   # ログイン済みではなかった場合
  #   unless logged_in?
  #     # アクセスしようとしたURLを記憶
  #     store_location
  #     flash[:danger] = "Please log in."
  #     redirect_to login_url
  #   end
  # end

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # # 管理者かどうか確認
  # def admin_user
  #   redirect_to(root_url) unless current_user.admin?
  # end
end
