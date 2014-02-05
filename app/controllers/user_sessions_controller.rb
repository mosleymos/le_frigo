class UserSessionsController < ApplicationController

  def new
  end

  def create
    if logged_in?
      flash.now.alert = "You must log out first."
      render action: :new
    else
      if login(params[:email], params[:password])
        redirect_back_or_to(:root, message: 'Logged in successfully.')
      else
        flash.now.alert = "Login failed."
        render action: :new
      end
    end
  end

  def destroy
    logout
    redirect_to(:root, message: 'Logged out!')
  end
end
