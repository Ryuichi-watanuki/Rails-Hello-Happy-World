class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Hello App!"
      redirect_to @user # redirect_to user_url(@user) と等価
    else
      render 'new'
    end
  end
  
  private

    # 7.3.2 https://railstutorial.jp/chapters/sign_up?version=5.1#sec-strong_parameters
    def user_params
      params.require(:user).permit(
        :name,
        :email,
        :password,
        :password_confirmation
      )
    end

end
