class Admin::UsersController < ApplicationController
  before_action :admin_user
  before_action :set_user, only: [:show, :edit, :update, :destroy]


  def index
    @users = User.all
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if params[:back]
      render :new
    else
      if @user.save
        redirect_to admin_users_path, notice: "ユーザーを作成しました！"
      else
        render :new
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザーを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice:"ユーザーを削除しました！"
  end

  def confirm
    @user = current_user.users.build(user_params)
    render :new if @user.invalid?
  end

  private

  def admin_user
    redirect_to(root_path) unless current_user.admin?
    flash[:danger] = '管理者以外立ち入り禁止‼︎'
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  en
end
