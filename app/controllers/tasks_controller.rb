class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    #@tasks = current_user.tasks
    if params[:sort_expired]
      @tasks = current_user.tasks.order(dead_line: :desc).page(params[:page])
    elsif params[:sort_priority]
      @tasks = current_user.tasks.order(priority: :asc).page(params[:page])
    else
      @tasks = current_user.tasks.order(created_at: :desc).page(params[:page])
    end

    if params[:name].present? && params[:number].present?
      @tasks = current_user.tasks.search_name(params[:name]).search_status(params[:number]).page(params[:page])
    elsif params[:name].present?
      @tasks = current_user.tasks.search_name(params[:name]).page(params[:page])
    elsif params[:number].present?
      @tasks = current_user.tasks.search_status(params[:number]).page(params[:page])
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
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
    @task = current_user.tasks.build(task_params)
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
