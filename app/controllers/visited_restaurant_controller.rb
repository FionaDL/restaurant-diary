class VisitedController < ApplicationController

  get '/visted/new' do
    if logged_in?
      erb :'visted_restaurants/new'
    else
      redirect to '/'
    end
  end

end
