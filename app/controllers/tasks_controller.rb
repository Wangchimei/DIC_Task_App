class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :show, :destroy]
  before_action :correct_user, only: [:edit]
  before_action :correct_user_or_admin, only: [:show]

  def index
    @task = current_user.tasks

    if params[:task]
      @tasks = @task.title_search(params[:task][:title]).status_search(params[:task][:status]).label_search(params[:task][:labels_ids])
      # @tasks = Task.joins(:label_relations).where(label_ids: label_ids)params[:task][:labels_ids]
      # @tasks = Task.searclabel_relationsh(params[:task][:title])
    elsif params[:sort_deadline]
      @tasks = @task.order(deadline: :asc)
    elsif params[:sort_status]
      @tasks = @task.order(status: :asc)
    elsif params[:sort_priority]
      @tasks = @task.order(priority: :desc)
    else
      @tasks = @task.order(created_at: :desc)
    end
    @tasks = @tasks.page(params[:page])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
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
    params.require(:task).permit(:title, :content, :deadline, :status, :priority, { label_ids: [] })
  end

  def correct_user
    if current_user.id != @task.user_id
      redirect_to task_path(@task)
      flash[:notice] = "ご本人以外の方が操作できません"
    end
  end

  def correct_user_or_admin
    if current_user.id != @task.user_id && !current_user.admin
      redirect_to tasks_path
      flash[:notice] = "権限ありません"
    end
  end
end
