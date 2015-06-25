class UsersController < ApplicationController
  before_action :no_repeat_login, only: [:create, :new]

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to bands_url
    else
      flash.now[:errors] = "Could not create an account with that email"
      redirect_to new_user_url
    end
  end

  def new
    @user = User.new
    render :new
  end

  def show
    render :show
  end

  private

  def no_repeat_login
    unless current_user.nil?
      redirect_to user_url(current_user)
    end
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
