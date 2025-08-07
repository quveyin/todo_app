class SessionsController < ApplicationController
  def new
    redirect_to tasks_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Hoş geldiniz, #{user.name}!"
      redirect_to tasks_path
    else
      flash.now[:error] = 'Geçersiz email veya şifre'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Başarıyla çıkış yaptınız'
    redirect_to login_path
  end
end