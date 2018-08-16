require 'rack-flash'

class UserController < ApplicationController
  use Rack::Flash


  get '/users/:id' do
    if logged_in?
      @user = User.find_by_id(current_user.id)
      erb :'users/show'
    else
      flash[:message] = "You aren't currently logged in. Please Sign Up or Log In."
      redirect to "/"
    end
  end

  get '/signup' do
    if logged_in?
      redirect to "/users/:#{current_user.id}"
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    @user = User.create(username: params[:username], password: params[:password])
    @user.save
    session[:id] = @user.id
    redirect to "/users/#{@user.id}"
  end

  get '/login' do
    if logged_in?
      redirect to "/users/:#{current_user.id}"
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by_username(params[:userame])
    if @user && @user.password = params[:password]
      session[:id] = @user.id
      redirect to "/users/:#{@user.id}"
    else
      flash[:message] = "The information you entered was incorrect. Please try again."
      erb :'users/login'
    end
  end

  get '/logout' do
   if logged_in?
     session.destroy
     redirect to '/login'
   else
     redirect to '/login'
   end
 end

end
