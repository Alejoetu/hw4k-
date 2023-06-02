class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({ "email" => params["email"] })
    if @user
      password_the_user_typed = params["password"]
      password_in_the_database = @user["password"]
      if BCrypt::Password.new(password_in_the_database) == password_the_user_typed
        session["user_id"] = @user["id"]
        flash["notice"] = "You are now logged-in."
        redirect_to "/places"
      else
        flash["notice"] = "Sorry, invalid email or password."
        redirect_to "/login"
      end
    else
      flash["notice"] = "Sorry, invalid email or password."
      redirect_to "/login"
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "Goodbye."
    redirect_to "/login"
  end
end