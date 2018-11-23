class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
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
      log_in @user # ユーザー登録中にログインする（8.2.5）
      flash[:success] = "Welcome to the Hello App!"
      redirect_to @user # redirect_to user_url(@user) と等価
    else
      render 'new'
    end
  end

  def edit
    # @user = User.find(params[:id])
  end

  def update
    # @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "設定を更新しました。"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "削除しました。"
    redirect_to users_url
  end
  
  private
    # 7.3.2 https://railstutorial.jp/chapters/sign_up?version=5.1#sec-strong_parameters
    def user_params
      params.require(:user).permit( :name,
                                    :email,
                                    :password,
                                    :password_confirmation )
    end

    # beforeアクション群

    def logged_in_user # ログイン済みユーザーかどうか確認
      unless logged_in?
        store_location
        flash[:danger] = "未ログイン状態です。"
        redirect_to login_url
      end
    end

    def correct_user  # 正しいユーザーかどうか確認
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user # 管理者かどうか確認
      redirect_to(root_url) unless current_user.admin?
    end
end
