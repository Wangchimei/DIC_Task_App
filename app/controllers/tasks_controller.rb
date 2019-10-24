class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :show, :destroy]
  PER = 5

  def index
    if params[:task].present? && params[:task][:search]
      @tasks = Task.title_search(params[:task][:title]).status_search(params[:task][:status])
      # @tasks = Task.search(params[:task][:title])
    elsif params[:sort_deadline]
      @tasks = Task.all.order(deadline: :asc)
    elsif params[:sort_status]
      @tasks = Task.all.order(status: :asc)
    elsif params[:sort_priority]
      @tasks = Task.all.order(priority: :desc)
    else
      @tasks = Task.all.order(created_at: :desc)
    end
    @tasks = @tasks.page(params[:page]).per(PER)
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
    params.require(:task).permit(:title, :content, :deadline, :status, :priority)
  end
end
