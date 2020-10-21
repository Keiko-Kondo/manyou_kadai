class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user

  def index

    # @search = Task.search(search_params)　
    @search_params = search_params
    # @tasks = Task.search(@search_params)
    if params[:sort_expired]
      @tasks = current_user.tasks.order("deadline ASC").page(params[:page]).per(6)
    elsif params[:sort_priority]
      @tasks = current_user.tasks.order("priority DESC").page(params[:page]).per(6)
    else
      @tasks = current_user.tasks.search(@search_params).order("created_at DESC").page(params[:page]).per(6)
    end

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
    @task = current_user.tasks.build(task_params)
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
    @task = current_user.tasks.build(task_params)
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

  def authenticate_user
    if @current_user == nil
      flash[:notice] = 'ログインしてください'
      redirect_to new_session_path
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end


end
