class SessionsController < ApplicationController
  before_action :no_repeat_login, only: [:create, :new]

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )
    if @user.nil?
      flash.now[:errors] = "We could not find that email/password combination"
      render :new
    else
      login_user!(@user)
      redirect_to bands_url
    end
  end

  def destroy
    log_out!
    redirect_to new_session_url
  end

  def no_repeat_login
    unless current_user.nil?
      redirect_to user_url(current_user)
    end
  end
end
