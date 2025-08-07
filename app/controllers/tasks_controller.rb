class TasksController < ApplicationController
  before_action :require_login
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle]
  
  def index
    @filter = params[:filter]
    
    case @filter
    when 'completed'
      @tasks = current_user.tasks.completed.recent
      @page_title = 'Tamamlanan Görevler'
    when 'pending'
      @tasks = current_user.tasks.pending.recent
      @page_title = 'Bekleyen Görevler'
    else
      @tasks = current_user.tasks.recent
      @page_title = 'Tüm Görevler'
    end
    
    @all_tasks = current_user.tasks
    @completed_tasks = @all_tasks.completed
    @pending_tasks = @all_tasks.pending
  end

  def show
  end

  def new
    @task = current_user.tasks.build
  end

  def edit
  end

  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      redirect_to tasks_path, notice: 'Görev başarıyla oluşturuldu.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Görev başarıyla güncellendi.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def toggle
    @task.toggle_completion!
    redirect_to tasks_path, notice: "Görev durumu değiştirildi: #{@task.status}"
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'Görev başarıyla silindi.'
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :completed)
  end
end