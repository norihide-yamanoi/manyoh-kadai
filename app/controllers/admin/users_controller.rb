class Admin::UsersController < ApplicationController
  before_action :admin_user
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.includes(:tasks).page(params[:page])
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
    @user = User.find(params[:id])
    @tasks = @user.tasks.page(params[:page])
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
    redirect_to admin_users_path, notice:"ユーザーを削除しました！",confirm: '本当に削除していいですか？'
  end

  def confirm
    @user = User.new(user_params)
    render :new if @user.invalid?
  end

  private

  def admin_user
    unless current_user.admin?
    redirect_to(tasks_path)
    flash[:danger] = '管理者以外立ち入り禁止‼︎'
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
end
