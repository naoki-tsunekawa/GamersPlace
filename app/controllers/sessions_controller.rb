class SessionsController < ApplicationController
  def new
  end

  def create
    # ログイン処理
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      # urlを記憶していた場合は記憶しているurlへ遷移し記憶していない場合はデフォルトのurlへ遷移する
      redirect_back_or user
    else
      # エラーメッセージを作成する
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    # ログイン中の時のみログアウト処理を行う
    log_out if logged_in?
    redirect_to root_url
  end
end
