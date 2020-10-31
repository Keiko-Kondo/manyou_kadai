class Admin::UsersController < ApplicationController
  before_action :if_not_admin
  before_action :set_user, only: [:show, :edit, :destroy, :update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    # @tasks = @user.tasks
    @tasks = @user.tasks.select(:task_name)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_url, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    # @user.destroy
    # @user.tasks.destroy
    # redirect_to admin_users_url, notice: 'User was successfully destroyed.'

    if @user.destroy
      redirect_to admin_users_url, notice: 'User was successfully destroyed.'
    else
      redirect_to admin_users_path, alert: "#{@user.errors[:base]}"
    end
  end


  private
    def if_not_admin
      redirect_to root_path unless current_user.admin?
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end


end
