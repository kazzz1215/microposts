class UsersController < ApplicationController
  
  before_action :set_user, only: [:edit, :update]
  before_action :check_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
  end
    
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = 'プロフィールを更新しました'
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :area, :profile, :password, :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def check_user
    @user = User.find(params[:id])
    if @user != current_user
      flash[:danger] = '不正なアクセスです'
      redirect_to root_path
    end
  end
  
end
