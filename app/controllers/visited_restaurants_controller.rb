require 'rack-flash'

class VisitedRestaurantsController < ApplicationController
  use Rack::Flash

  get '/visited_restaurants' do
    erb :'visited_restaurants/show'
  end

  get '/visited_restaurants/new' do
    if logged_in?
      erb :'visited_restaurants/new'
    else
      redirect to '/'
    end
  end

  post '/visited_restaurants' do
    binding.pry
    if current_user.visited_restaurants.find_by(name: params[:name], location: params[:location])
      flash[:notice] = "That restaurant already exists in your diary."
      redirect to "/visited_restaurants/new"
    elsif !params[:name].empty? && !params[:location].empty? && !params[:thougts].empty? && !params[:rating].empty?
      @restaurant = VisitedRestaurant.create(name: params[:name], location: params[:location], thougts: params[:thougts], rating: params[:rating])
      @restaurant.user_id = current_user.id
      @restaurant.save

      flash[:message] = "The new restaurant has been added to your diary."
      redirect to "/users/:#{@restaurant.user_id}"
    else
      flash[:notice] = "Please enter all the information to add a new restaurant."
      redirect to "/visited_restaurants/new"
    end
  end

  get '/visited_restaurants/:id' do
    if logged_in?
      @restaurant = current_user.visited_restaurants.find(params[:id])
      erb :'visited_restaurants/show'
    else
      redirect to '/'
    end
  end

  get '/visited_restaurants/:id/edit' do
    if logged_in?
      @restaurant = current_user.visited_restaurants.find(params[:id])
      erb :'visited_restaurants/edit'
    else
      redirect to '/'
    end
  end

  post '/visited_restaurants/:id' do
    @restaurant = current_user.visited_restaurants.find(params[:id])
    if !params[:name].empty? && !params[:location].empty? && !params[:thougts].empty? && params[:rating]
      @restaurant.update(name: params[:name], location: params[:location], thougts: params[:thougts], rating: params[:rating])
      @restaurant.save

      flash[:message] = "The restaurant has been updated to your diary."
      redirect to "/users/:#{@restaurant.user_id}"
    else
      flash[:message] = "Please enter all the information to update restaurant in your diary."
      redirect to "/visited_restaurants/:new"
    end
  end

  delete '/visited_restaurants/:id/delete' do
      @restaurant = current_user.visited_restaurants.find(params[:id])
        @restaurant.delete
      redirect to "/users/:#{current_user.id}"
  end


end
