class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:sort_expired]
      @tasks = Task.all.order(dead_line: :desc).page(params[:page])
    elsif params[:sort_priority]
      @tasks = Task.all.order(priority: :asc).page(params[:page])
    else
      @tasks = Task.all.order(created_at: :desc).page(params[:page])
    end

    if params[:name].present? && params[:number].present?
      #両方name and statusが成り立つ検索結果を返す
      @tasks = Task.search_name(params[:name]).search_status(params[:number]).page(params[:page])
      #渡されたパラメータがtask nameのみだったとき
    elsif params[:name].present?
      @tasks = Task.search_name(params[:name]).page(params[:page])
      #渡されたパラメータがステータスのみだったとき
    elsif params[:number].present?
      @tasks = Task.search_status(params[:number]).page(params[:page])
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: "タスクを作成しました！"
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
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end

  def confirm
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end


  private

  def task_params
    params.require(:task).permit(:name, :detail, :dead_line, :status, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
