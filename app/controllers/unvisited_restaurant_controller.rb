require 'rack-flash'

class UnvisitedController < ApplicationController
  use Rack::Flash

  get '/unvisted/new' do
    if logged_in?
      erb :'unvisted_restaurants/new'
    else
      redirect to '/login'
    end
  end

  post '/unvisited' do
    @restaurant = UnvisitedRestaurant.create(name: params[:name], location: params[:location])
    @restaurant.user_id = current_user.id
    @restaurant.save

    flash[:message] = "The new restaurant has been added to your wish list."
    redirect to "/users/:#{@restaurant.user_id}"
  end

end
