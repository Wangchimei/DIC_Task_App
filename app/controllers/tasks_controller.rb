class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :show, :destroy]

  def index
    @tasks = Task.all.order(created_at: :desc)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path
      flash[:notice] = "タスクを作成しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path
      flash[:notice] = "タスクが更新されました"
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
    flash[:notice] = "タスクが削除されました"
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content)
  end
end
