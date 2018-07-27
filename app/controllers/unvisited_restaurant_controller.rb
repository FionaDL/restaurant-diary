class UnvisitedRestaurantController < ApplicationController

  get '/unvisited_restaurants'  do
    erb :'unvisted_restaurants/show'
  end
end
