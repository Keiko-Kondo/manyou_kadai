class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @search_params = search_params
    @tasks = Task.search(@search_params)
    @tasks = Task.all.order("deadline ASC") if params[:sort_expired]
    # else
    #   @tasks = Task.all.order("created_at DESC")
    #     if params[:task_name].present? && params[:status] == "選択なし"
    #       @tasks = Task.where('task_name LIKE ?', "%#{params[:task_name]}%")
    #     elsif params[:task_name].present? && params[:status] != "選択なし"
    #       @tasks = Task.where(status: params[:status]) and Task.where('task_name LIKE ?', "%#{params[:task_name]}%")
    #     elsif params[:task_name].empty? && params[:status] != "選択なし"
    #       @tasks = Task.where(status: params[:status])
    #     elsif params[:task_name].empty? && params[:status] == "選択なし"
    #       @tasks = Task.all.order("created_at DESC")
    #     end
    # end
  end

  def new
    if params[:back]
      @task = Task.new(task_params)
    else
      @task = Task.new
    end
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to new_task_path, notice: 'Task was successfully created.'
      else
        render :new
      end
    end
  end

  def confirm
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  def show
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:task_name, :details, :deadline, :priority, :status)
  end

  def search_params
    params.fetch(:search, {}).permit(:task_name, :status)
  end
end
