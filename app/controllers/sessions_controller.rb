class SessionsController < ApplicationController
  
  def new
  end

  def create
    # paramsの構造 8.1.3 で参照できる。下のはemailを取得している
    @user = User.find_by(email: params[:session][:email].downcase)
    # 「ユーザーがデータベースにあり、かつ、認証に成功した場合にのみ」
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_back_or @user
    else
      flash.now[:danger] = 'アドレスとパスワードが一致しません'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
