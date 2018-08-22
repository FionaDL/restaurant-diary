require 'rack-flash'

class UnvisitedRestaurantsController < ApplicationController
  use Rack::Flash

  get '/unvisited_restaurants/new' do
    if logged_in?
      erb :'unvisited_restaurants/new'
    else
      redirect to '/login'
    end
  end

  post '/unvisited_restaurants' do
    if current_user.unvisited_restaurants.find_by(name: params[:name], location: params[:location])
      flash[:notice] = "That restaurant already exists on your wish list."
      redirect to "/unvisited_restaurants/new"
    elsif !params[:name].empty? && !params[:location].empty?
      @restaurant = UnvisitedRestaurant.create(name: params[:name], location: params[:location])
      @restaurant.user_id = current_user.id
      @restaurant.save

    flash[:message] = "The new restaurant has been added to your wish list."
    redirect to "/users/:#{@restaurant.user_id}"
  else
    flash[:message] = "Please enter all the information to add a new restaurant."
    redirect to "/unvisited_restaurants/new"
    end
  end



end
