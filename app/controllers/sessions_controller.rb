class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    p user
    if user && user.authenticate(params[:session][:password])
      # redirect user to show page
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      #remember user
      redirect_to user #Rails automatically converts this to the route for the user’s profile page -> user_url(user)
      #debug user later
    else
      flash.now[:danger] = 'Invalid email or password'
      render 'new'
    end

  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
