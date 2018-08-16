class UnvisitedController < ApplicationController

  get '/unvisted/new' do
    if logged_in?
      erb :'unvisted_restaurants/new'
    else
      '/login'
    end
  end

  post '/unvisited' do

  end

end
