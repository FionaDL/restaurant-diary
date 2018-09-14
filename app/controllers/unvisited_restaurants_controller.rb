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
      flash[:message] = "That restaurant already exists on your wish list."
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

  get '/unvisited_restaurants/:id/edit' do
    if logged_in?
      @restaurant=current_user.unvisited_restaurants.find(params[:id])
      erb :'unvisited_restaurants/edit'
    else
      redirect to '/login'
    end
  end


  patch '/unvisited_restaurants/:id' do
      if params[:name] == "" || params[:location] == ""
        redirect to "/unvisited_restaurants/#{params[:id]}/edit"
      else
        @restaurant = current_user.unvisited_restaurants.find(params[:id])
           @restaurant.update(name: params[:name], location: params[:location])
            redirect to "/users/#{current_user.id}"
      end
    end

  put '/unvisited_restaurants/:id' do

    @restaurant = current_user.unvisited_restaurants.find(params[:id])
    @visited_restaurant = VisitedRestaurant.create(name: @restaurant.name, location: @restaurant.location, user_id: @restaurant.user_id)
    @restaurant.delete
    redirect to "/visited_restaurants/#{@visited_restaurant.id}/edit"
  end

  delete '/unvisited_restaurants/:id/delete' do
      @restaurant = current_user.unvisited_restaurants.find(params[:id])
        @restaurant.delete
      redirect to "/users/:#{current_user.id}"
  end


end
