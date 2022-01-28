
class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.authenticate_with_credentials(params[:email], param[:password])
      puts user.id
      session[:user_id] = user.id
      redirect_to '/'
    else
      puts "redirected"
      redirect_to '/login'
    end    
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end