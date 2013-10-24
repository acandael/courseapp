class SessionsController < ApplicationController

  def create
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path, notice: "You are signed in, enjoy!"
    else
      flash[:alert] = "Invalid email or password"
      redirect_to sign_in_path
    end
  end
end
