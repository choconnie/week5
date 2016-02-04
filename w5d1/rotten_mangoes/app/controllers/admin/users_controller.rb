class Admin::UsersController < ApplicationController

  before_filter :restrict_access_admin_page

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.admin.nil?
      @user.admin = false
    end

    if @user.save
      redirect_to admin_user_path(:id)
    else
      render :new
    end
  end


  def show
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_user_path(current_user.id)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_user_path(current_user.id)
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

end
